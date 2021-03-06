function [theta] = normalEqn(X, y, lambda)
%NORMALEQN Computes the closed-form solution to linear regression 
%   NORMALEQN(X,y) computes the closed-form solution to linear 
%   regression using the normal equations.

theta = zeros(size(X, 2), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the code to compute the closed form solution
%               to linear regression and put the result in theta.
%

% ---------------------- Sample Solution ----------------------

A = zeros(size(X,2),size(X,2));
A = hello(A,size(X,2));

theta = pinv((X' * X) + (lambda.*A)) * X' * y;



% -------------------------------------------------------------


% ============================================================

end
