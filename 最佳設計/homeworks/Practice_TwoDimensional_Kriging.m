% kriging fitting and prediction demo for 2d problem
% NTU, ME, SOLab
% 2022/09/27

clc; clear; close all;
%% Step 0: Load data file
% x1,x2: 21*21 points between 0 and 2
% z: 21*21 points
load('TwoDimensional_data.mat');
lb = [0, 0];
ub = [2, 2];
% Reshape
x1_flatten = reshape(x1,[21*21 1]);
x2_flatten = reshape(x2,[21*21,1]);
z_flatten = reshape(z,[21*21,1]);

x_data = [x1_flatten, x2_flatten];
z_data = z_flatten;

%% Step 1: Polt the original data
figure(1);
% Hint: plot3
% ----- to do -----
plot3(x1_flatten,x2_flatten,z_data,'r.')
hold on
%% Step 2: Modeling through the all data.
% Fitting kriging
% Hint: parameter = f_variogram_fit(data x, data z, lb, ub);
% ----- to do -----
parameter = f_variogram_fit(x_data, z_data, lb, ub);
% Kriging prediction.
% Hint: Kriging prediction = f_predictkrige(data x, parameter);
% ----- to do -----
[z_krige,sigma]=f_predictkrige(x_data, parameter);
% Plot the kriging average in the interval [0,2].
% ----- to do -----
plot3(x1_flatten,x2_flatten,z_krige,'g')
%% Step 3: Estimate error (known model)
% figure(2);
z_origin = (x1_flatten.^2-5*x2_flatten.^2+x1_flatten.*x2_flatten-8*x1_flatten+9*x2_flatten-5);
plot3(x1_flatten,x2_flatten,z_origin,'b--')
xlabel 'x1'
ylabel 'x2'
zlabel 'z'
hold off
% Estimate error 
% ----- to do -----
err=abs((z_origin-z_krige)./z_origin)*100;
% Plot error with respect to x1 and x2  
% ----- to do -----
figure(2);
plot3(x1_flatten,x2_flatten,err,'.')
%% Step 4: Estimate error (unknown model, leave one out)
% Leave one out: Take out the 1 sample, and model through the remaining n-1 data.
% Generate 21*21 models.
error=zeros(21*21,1);
for i = 1:size(z_flatten,1) 
    % Take out the ith sample.
    % ----- to do -----
    if i==1
        z_estimate=z_data(2:441,:);
        x_estimate=x_data(2:441,:);
    elseif i==441
        z_estimate=z_data(1:440,:);
        x_estimate=x_data(1:440,:);
    else
        z_estimate=[z_data(1:i-1,:) ; z_data(i+1:441,:)];
        x_estimate=[x_data(1:i-1,:) ; x_data(i+1:441,:)];
    end
    % Modeling through the remaining 21*21-1 data. (similar Step 2)
    % ----- to do -----
    parameter = f_variogram_fit(x_estimate, z_estimate, lb, ub);
    [z_est_krige,sigma]=f_predictkrige(x_data, parameter);
    % Estimate error between model prediction and provided data 
    % ----- to do -----
    error(i)=abs((z_est_krige(i)-z_data(i))/z_data(i))*100;
end
% Polt error with respect to each model 
 % ----- to do -----
 figure(3)
 plot3(x1_flatten,x2_flatten,error,'b.')
 figure(4)
 histogram(error)