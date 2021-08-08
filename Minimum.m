%% Minimum
% mf = Mediana(f) 
% This function evaluates the simple moving average of 4 points
%
% The required arguments are:
%
% f, An array with the values of f(x)
% 
% The arguments that are returned are:
% mf, The 4 points moving average
function mf = Minimum(f)
% Determine data length
numData = length(f);
% Create the averages vector
mf = zeros(1, numData);
mf(4:numData) = min(numData - 3:numData);
%(f(1:numData - 3) + f(2:numData - 2) + ...
    %f(3:numData - 1) + f(4:numData))/4;
    %median(4:numData)
    % Slope average
    %df(2:numData-3) = (f(5:numData) - f(2:numData-3))/(3*delta_x);
end