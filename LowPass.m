%%y = LowPass(u, alpha)
function y = LowPass(u, alpha)
% Determine data length
numData = length(u);
% Create the averages vector
y = zeros(1, numData);
for n = 1:numData - 1
    y(n+1) = y(n)*(1-alpha) + alpha*u(n);
end
end