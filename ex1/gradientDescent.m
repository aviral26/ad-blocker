function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
disp(m)
J_history = zeros(num_iters, 1);
h = 0;
delta = zeros(2,1);
for iter = 1:num_iters
    
	predictions = X * theta;
	errors = predictions - y;
	
	delta = X' * errors;
	delta = (1/m).*delta;
	theta = theta - alpha.*delta;
	
     ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);

end

end
