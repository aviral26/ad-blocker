function [J, grad] = computeCost(theta, X, y)

m = length(y); 
grad = zeros(size(theta));
J = 0;

predictions = (theta' * X')';
sqerrors = (predictions - y).^2;
J = (0.5/m) * sum(sqerrors);

errx = zeros(length(y));

for i = 1 : size(theta)

	errx = (predictions - y).*X(:,i);
	grad(i) = (1/m) * sum(errx);
end

end

