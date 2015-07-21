

%% Initialization

%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
data = csvread('C:\Users\Aviral\Desktop\MinorProject5thSem\data_features_2.csv');
x = data(2:size(data, 1), :);
allX = x;

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
X = allX(21:700, :);
data_o = [data(2:size(data,1),2)];

ally = data_o + data(2:size(data,1),7) + data(2:size(data,1), 6);
y = ally(21:700, :);
m = length(y);

% Print out some data points
%fprintf('First 10 examples from the dataset: \n');
%[X(1:10,:) y(1:10,:)]

%figure;
%plotData(X(:, 1), y);
%figure;
%plot(X(:, 2), y(:, :))
%figure;
%plot(X(:, 3), y(:, :))
%figure;
%plot(X(:, 4), y(:, :))

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

%[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];

lambda = 0.01;
fprintf('Running normal equation ...\n');
theta = normalEqn(X, y, lambda);



err = 0;
for j=1:20,
	price = [1 allX(j, :)];
	price = price*theta
	correct_ans = ally(j, 1)


	if correct_ans ~= 0,
		err_j = (abs(correct_ans - price)/correct_ans)
	else,
		err_j = abs(price)
	end;

	err = err + err_j;
end;



% ============================================================

fprintf(['Average error: ' ...
         '(using normal equation):\n %f\n'], err/100);

%fprintf('Program paused. Press enter to continue.\n');
%pause;
%0,479,16,0,1361532428,582,1,21441,0,145,4,4,1
%0,119,00,1,1363459573,49,0,6001,0,49,3,6,0


