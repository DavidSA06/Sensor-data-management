% Make an fitting for Y=C-k[exp(-a0*X)+b*exp(-a1*X)]
% using Gauss-Newton method
% 5 points by second
% Remove data repetition

clear											%Remove elements from workspace
clc												%Clean command window
%clf											%Remove figures
figure											%Create figure window
data1 = load('file.lvm');
S = data1(:,2);									%Take the second data column
N = size(S);
n = N(1);							
xaxis = 1:1:n;									%Create a vector (for X axis)


for i = 1:n;
	S_s(i) = S(i) - S(1);						%Start from 0V (reference)
end


plot(xaxis,S_s,'*')								%Graph X axis vs Frequence with asterisks
%

xin = input('X start: ');						%Choose an starting point to WORK range
xfi = input('End of X: ');						%Choose an ending point to WORK range
n_n = (xfi - xin) + 1;							%Take the range between the two previous points
x = 1:1:n_n;									%Create a new vector from WORK data
x1 = 0:0.2:(n_n - 1) / 5;						%Create a new vector with a steady state portion
for j = 1:n_n;									%For every selected data...
	Y(j) = abs(S_s(xin + j - 1) ...
	- S_s(xin(1))); 							%Apply the absolute value to flip around X axis
	X(j) = x1(j);					        	%Create a flipped vector
end


%% Initial values for fitting
c = 100;							            %Proposed values based on experience
k = 80;
t0 = 4;
b = 1;
t1 = 40;
  
a0 = -1/t0;										%Mathematical exponent change to e^-(t / \tau_0) a e^(t * a_0)...
a1 = -1/t1;										%...For easy reading
theta = [c; k; a0; b; a1];						%Vector of constants to iterate


for j = 1:n_n;									%For every selected data...
	F(j) = theta(1) + (theta(2) ...
		* (exp((theta(3) * X(j))) + theta(4)...
		* (exp((theta(5) * X(j))))));			%Fitting equation
	w(j) = Y(j) - F(j);							%Residuals calculation, the results of the current fit are subtracted from the experiment data
	dc(j) = 1;									%Derivative of the fit equation with respect to c 
	dk(j) = (exp(theta(3) * X(j))...
		+ theta(4) * (exp(theta(5) * X(j))));	%Derivative of the fit equation with respect to k
	da0(j) = theta(2) * X(j)... 
		* (exp(theta(3) * X(j)));				%Derivative of the fit equation with respect to a0
	db(j) = (theta(2)...
		* (exp(theta(5) * X(j))));				%Derivative of the fit equation with respect to b
	da1(j) = theta(4) ...
		* theta(2) * X(j)...
		* (exp(theta(5) * X(j)));				%Derivative of the fit equation with respect to a1
end


J = [dc; dk; da0; db; da1]';					%Apply conjugate transposed to Jacobian 				
JT = [dc; dk; da0; db; da1];					%Trasnposed Jacobian
R = JT*J;										%Calculate (JT * I * J)^-1 * JT * w'	
J_1 = inv(R);
ajust = J_1 * JT * w';
theta1 = theta + ajust;							%Constants are corrected
F1 = theta1(1) + (theta1(2)...
	* (exp(theta1(3) * x1)...
	+ theta1(4) * exp(theta1(5) * x1)));		%New fitting equation
x_arit = mean(F1);								%Fitting average
y_arit = mean(Y);								%Extracted data average
for j = 1:n_n;									%For every selected data...
	w2(j) = (Y(j) - F1(j))^2;					%Each residual squared
	x_x(j) = F1(j) - x_arit;					%Fitting variance
	y_y(j) = Y(j) - y_arit;						%Data variance
	xx(j) = x_x(j).^2;
	yy(j) = y_y(j).^2;
	x_y(j) = x_x(j)*y_y(j);						%Covariance
end
X_Y = sum(x_y);									%Sum of Covariance
XX = sum(xx);									%Sum of fitting variance
YY = sum(yy);									%Sum of data variance
R1 = (X_Y / sqrt(XX * YY))^2;					%Correlation coefficient calculation
error_estan_ajuste = sum(w2) / (n_n - 2);		%Standard error 
theta = theta1;									%Substitute constants for final fitting

	disp('valores verdaderos');					%Show the variable
	theta1
	 taud1 = 1 / theta1(3)						%Convert t1 = 1/a0;
	 taud2 = 1 / theta1(5)						%Convert t2 = 1/a1;
	plot(x1,Y,'*m')								%Graph worked data
	hold on										%Retain current frame
	plot(x1,F1,'b')								%Graph fitting
	R1

%%
d = 0:0.2:(n_n - 1) / 5;
V = theta1(2)...
	* (exp(d * theta(3)) - 1);					%Graph only first exponential function
V2 = theta1(2)...
	* theta1(4) * (exp(d * theta(5)) - 1);		%Graph only first exponential function
Vt = theta1(1)+theta1(2)...
	*(exp(d*theta1(3)+theta(4)*exp(d*theta1(5))));
plot(d,V,'b')									%Charts
hold on
plot(d,V2,'m')
plot(x1,F1,'black')
