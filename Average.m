%% Average
% pf=Average(f) 
% This function evaluates the simple moving average of 4 points
%
% The required arguments are:
%
% f, An array with the values of f(x)
% 
% The arguments that are returned are:
% pf, The 4 points moving average
function pf = Average(f)
% Determine data length
numDatos = length(f);
% Create the averages vector 
pf = zeros(1, numDatos);
pf(4:numDatos) = (f(1:numDatos - 3) + f(2:numDatos - 2) + ...
    f(3:numDatos - 1) + f(4:numDatos))/4;
    % Slope average
    %df(2:numDatos-3) = (f(5:numDatos) - f(2:numDatos-3))/(3*delta_x);
end