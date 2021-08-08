%Clean workspace and memory / clean window
clear, clf


% Load data
flow = [500,400,300,200];    
ppm = [713,891,1189,1783];
prefix = 'B'; %String variable


% Filter smoothing parameter
alpha = 0.1;
% subplot(2,2,1); hold on;
for n = 1:4
    % Load data series
    name = [prefix, num2str(n), ' (25)(17)(', num2str(flow(n)),...
        ').txt'];
    
% Load file
d = load(name);

% Determine the derivative using the function
df3 = Derivative(d(:,1), d(:,2), 3); %First x, independent variable
df1 = Derivative(d(:,1), d(:,2), 1); %Second, f(x)
df2 = Derivative(d(:,1), d(:,2), 2); %Third, scalar associated to
df4 = Derivative(d(:,1), d(:,2), 4); %the derivative order

% Evaluate the filtering (Low-pass Filter) using a function
df3f = LowPass(df3, alpha ) ; %First the calculation of the derivative
df1f = LowPass(df1, alpha ) ; %Second, smoothing parameter
df2f = LowPass(df2, alpha ) ;
df4f = LowPass(df4, alpha ) ;

% Determine moving average using 4 points
df3p = df3; % Already averaged by definition
df1p = Average(df1);
df2p = Average(df2);
df4p = Average(df3);

% Determine moving median using 4 points
df3n = Median(df3); 
df1n = Median(df1);
df2n = Median(df2);
df4n = Median(df3);

% Determine moving maximum using 4 points
df3x = Maximum(df3); 
df1x = Maximum(df1);
df2x = Maximum(df2);
df4x = Maximum(df3);

% Determine moving minimum using 4 points
df3m = Minimum(df3); 
df1m = Minimum(df1);
df2m = Minimum(df2);
df4m = Minimum(df3);

% Graph the data
figure (1)
x1 = 1500; %Lower end of range
x2 = 1600; %Upper end of range
subplot(2,3,1); %2x3 Tiling, crude data in 1
plot(d(:,2)), hold on % Graph 2nd column of the file
xlim([x1,x2])

% Hallamos el maximo
[maxdf(n,3), c3]=max(df3(x1:x2)); %Se calcula el m�ximo de dfx
[maxdf(n,1), c1]=max(df1(x1:x2)); %(la derivada)
[maxdf(n,2), c2]=max(df2(x1:x2)); %Se nombra como maxdf
[maxdf(n,4), c4]=max(df4(x1:x2));

% Find the maximum of the filtered
[maxdff(n,5), c3] = max(df3f(x1:x2)); %Calculate dfxf maximum
[maxdff(n,6), c1] = max(df1f(x1:x2)); %(derivative filter)
[maxdff(n,7), c2] = max(df2f(x1:x2)); %Named as maxdff
[maxdff(n,8), c4] = max(df4f(x1:x2));

% Find the maximum of the averaged
maxdfp(n,9) = max(df3p(x1:x2)); %Calculate dfxp maximum
maxdfp(n,10) = max(df1p(x1:x2)); %(average)
maxdfp(n,11) = max(df2p(x1:x2)); %Named as maxdfp
maxdfp(n,12) = max(df4p(x1:x2));

% Find the maximum of the median
maxdfn(n,13) = max(df3n(x1:x2)); %Calculate dfxn maximum
maxdfn(n,14) = max(df1n(x1:x2)); %(median)
maxdfn(n,15) = max(df2n(x1:x2)); %Named as maxdfn
maxdfn(n,16) = max(df4n(x1:x2));

% Find the maximum of the maximum
maxdfx(n,17) = max(df3x(x1:x2)); %Calculate dfxx maximum
maxdfx(n,18) = max(df1x(x1:x2)); %(maximum)
maxdfx(n,19) = max(df2x(x1:x2)); %Named as maxdfx
maxdfx(n,20) = max(df4x(x1:x2));

% Find the maximum of the minimum
maxdfm(n,21) = max(df3m(x1:x2)); %Calculate dfxx minimum
maxdfm(n,22) = max(df1m(x1:x2)); %(minimum)
maxdfm(n,23) = max(df2m(x1:x2)); %Named as maxdfm
maxdfm(n,24) = max(df4m(x1:x2));

subplot(2,3,2) %2x3 Tiling, Y derivatives and filters in 2
plot(df3,'k'); hold on
plot(df1,'r');
plot(df2,'g');
plot(df4,'b');

plot(df3f,':k');
plot(df1f,':r');
plot(df2f,':g');
plot(df4f,':b'); 

subplot(2,3,3) %2x3 Tiling, averages in 3
plot(df3p,':k');hold on
plot(df1p,':r');
plot(df2p,':g');
plot(df4p,':b'); 

hold off

xlim([x1,x2]) %The x-axis interval marked above
ylim([0,5e-4]) %The y-axis interval 
% input('Press enter...');
end
subplot(2,3,4) %Tile at 2x3, set derivative maximums at 4
plot(ppm, maxdf(:,3),'d-k'), hold on; %diamonds
plot(ppm, maxdf(:,1),'d-r');
plot(ppm, maxdf(:,2),'d-g');
plot(ppm, maxdf(:,4),'d-b'), 

% Filtered data
subplot(2,3,5) %Tile at 2x3, set derivative filter maximums at 5
plot(ppm, maxdff(:,5),'*-k'); hold on; %asterisks 
plot(ppm, maxdff(:,6),'*-r');
plot(ppm, maxdff(:,7),'*-g');
plot(ppm, maxdff(:,8),'*-b'), 

subplot(2,3,6) %Tile at 2x3, set average derivative maximums at 6 
plot(ppm, maxdfp(:,9),'o-k'); hold on; %circles
plot(ppm, maxdfp(:,10),'o-r');
plot(ppm, maxdfp(:,11),'o-g');
plot(ppm, maxdfp(:,12),'o-b'), 

hold off
% subplot(2,2,1); hold off

figure (2)
subplot(2,2,1) %Tile at 2x2, set average maximums at 4
plot(ppm, maxdfp(:,9),'-k'), hold on; %lines
plot(ppm, maxdfp(:,10),'-r');
plot(ppm, maxdfp(:,11),'-g');
plot(ppm, maxdfp(:,12),'-b'), 

subplot(2,2,2) %Tile at 2x2, set median maximums at 4
plot(ppm, maxdfn(:,13),'d-k'), hold on; %diamonds
plot(ppm, maxdfn(:,14),'d-r');
plot(ppm, maxdfn(:,15),'d-g');
plot(ppm, maxdfn(:,16),'d-b'), 

subplot(2,2,3) %Tile at 2x2, set maximums at 4
plot(ppm, maxdfx(:,17),'*-k'), hold on; %asterisks
plot(ppm, maxdfx(:,18),'*-r');
plot(ppm, maxdfx(:,19),'*-g');
plot(ppm, maxdfx(:,20),'*-b'), 

subplot(2,2,4) %Tile at 2x2, set minimums at 4
plot(ppm, maxdfm(:,21),'o-k'), hold on; %circles
plot(ppm, maxdfm(:,22),'o-r');
plot(ppm, maxdfm(:,23),'o-g');
plot(ppm, maxdfm(:,24),'o-b'), 

hold off