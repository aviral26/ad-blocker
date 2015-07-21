function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

predictions = sigmoid((theta' * X')');

cost = (-y.*(log(predictions))) - ((1.-y).*(log(1.-predictions)));

sumt = sum(theta.^2);
sumt = sumt - (theta(1)^2);

J = (1
/m)*sum(cost) + [(lambda/(2*m)) * sumt];

errx = zeros(length(y));
errx = (predictions - y).*X(:,1);

grad(1) = ((1/m) * sum(errx));

for i = 2 : size(theta)

	errx = (predictions - y).*X(:,i);
	grad(i) = ((1/m) * sum(errx)) + ((lambda/m).*theta(i));
end



% =============================================================

end
