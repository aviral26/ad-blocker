function [theta, J_history, theta1, theta2, J] = gradientDescentMulti(X, y, theta, alpha, num_iters)

m = length(y); % number of training examples
J_history = zeros(num_iters, 1);
theta1 = zeros(num_iters, 1);
theta2 = zeros(num_iters, 1);
J = zeros(num_iters, num_iters);

for iter = 1:num_iters

	predictions = X * theta;
	errors = predictions - y;
	
	delta = X' * errors;
	delta = (1/m).*delta;
	theta = theta - alpha.*delta;
	theta1(iter,1) = theta(1,1);
	theta2(iter,1) = theta(2,1);    
    	J_history(iter) = computeCostMulti(X, y, theta);

end

t = [0; 0];

for i = 1 : num_iters
	for j = 1 : num_iters
		t = [theta1(i,1); theta2(j,1)];
		J(i,j) = computeCostMulti(X, y, t);
	end

end

end