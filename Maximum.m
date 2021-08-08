%% Maximum
% xf = Maximum(f) 
% This function evaluates the simple moving average of 4 points
%
% The required arguments are:
%
% f, Un array con los valores de f(x)
% 
% The arguments that are returned are:
% mf, The 4 points moving maximum
function xf = Maximum(f)
% Determine data length
numData = length(f);
% Create the averages vector
xf = zeros(1, numData);
xf(4:numData) = max(numData - 3:numData);
%(f(1:numData - 3) + f(2:numData - 2) + ...
    %f(3:numData - 1) + f(4:numData))/4;
    %median(4:numData)
    % Slope average
    %df(2:numData-3) = (f(5:numData) - f(2:numData-3))/(3*delta_x);
end