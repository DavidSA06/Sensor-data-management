%% df = Derivative(x,f,order) 
% This function evaluates the derivative 
% numerically using the slope average equation
% and the 1st, 2nd, and 4th order approximations
% 
% The required arguments are:
% x, An array with the values of the independent variable 
% f, Un array con los valores de f(x)
% order, A scalar that determines the order you want to use:
% 3: Slope eq. 1: 1st order, 2: 2nd order, 4: 4th order
% 
% The arguments that are returned are:
% df, The numerical derivative with the specified order
function df = Derivative(x, f, order)
% Determine data length
numData = length(f);
% Determine time increment (delta t)
delta_x = x(2) - x(1);
% Create the derivatives vector
df = zeros(1, numData);
% Choose derivative order
if order == 3
    % Slope average
    df(2:numData - 3) = (f(5:numData) - f(2:numData - 3))/(3*delta_x);
elseif order == 1
    % 1st order approximation
    df(1:numData - 1) = ( f(2:numData) - ...
        f(1:numData - 1) )/...
        delta_x;
elseif order == 2
    % 2nd order approximation
    df(2:numData - 1)=(f(3:numData) - f(1:numData - 2))/(2*delta_x);
elseif order == 4
    % 4th order approximation
    df(3:numData - 2)= 2*(f(4:numData - 1) - f(2:numData - 3))/(3*delta_x) -...
        (f(5:numData) - f(1:numData - 4))/(12*delta_x);
end