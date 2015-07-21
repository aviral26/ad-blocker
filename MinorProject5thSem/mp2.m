

%% Initialization

%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
data = csvread('C:\Users\Aviral\Desktop\MinorProject5thSem\data_features_2.csv');
x = data(2:size(data, 1), :);
allX = x(:, [1 3 4 5 7 10 11 12 13]);

%allX = [allX allX(:, 1).^2];
%allX = [allX allX(:, 1).^3];
%allX = [allX allX(:, 2).^2];
%allX = [allX allX(:, 2).^5];
%allX = [allX allX(:, 3).^2];
%allX = [allX allX(:, 4).^2];
%allX = [allX allX(:, 5).^2];
%allX = [allX allX(:, 3).^0.5];
%allX = [allX allX(:, 4).^0.5];
%allX = [allX allX(:, 5).^0.5];

n_features = size(allX, 2) + 1;
X = allX(21:735, :);
ally = data(:, 8); + data(:, 2) + data(:, 6);
y = ally(21:735, :);
m = length(y);

% Print out some data points
fprintf('First 10 examples from the dataset: \n');
[X(1:10,:) y(1:10,:)]

figure;
plotData(X(:, 1), y);
figure;
plot(X(:, 2), y(:, :))
figure;
plot(X(:, 3), y(:, :))
figure;
plot(X(:, 4), y(:, :))

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];


fprintf('Running gradient descent ...\n');

% Choose some alpha value
alpha = 0.3;
num_iters = 400;

% Init Theta and Run Gradient Descent
theta = zeros(n_features, 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% Plot the convergence graph
%figure;
%plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
%xlabel('Number of iterations');
%ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');

%theta


err = 0;
for j=11:20,
	price = [1];
	for i=1:length(theta)-1,
		tmp = (allX(j, i) - mu(i)) / sigma(i);
		price = [price tmp];
	end;
	price = price*theta
	correct_ans = ally(j, 1)

	if correct_ans ~= 0,
		err = err + (abs(correct_ans - price)/correct_ans)
	else,
		err = err + abs(price)
	end;
end;



% ============================================================

fprintf(['Average error: ' ...
         '(using gradient descent):\n %f\n'], err/10);

%fprintf('Program paused. Press enter to continue.\n');
%pause;
%0,479,16,0,1361532428,582,1,21441,0,145,4,4,1
%0,119,00,1,1363459573,49,0,6001,0,49,3,6,0


