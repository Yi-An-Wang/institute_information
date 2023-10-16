% kriging fitting and prediction demo for 1d problem
% NTU, ME, SOLab
% 2022/09/27

clc; clear; close all;
%% Step 0: Load data file
% x: 200 points between 0 and 2
% y: 200 points
load('OneDimensional_data.mat');
lb = 0;
ub = 2;

%% Step 1: Polt the original data
figure(1);
% ----- to do -----
plot(x,y,'r.')
hold on
%% Step 2: Modeling through the all data.
% Fitting kriging
% Hint: parameter = f_variogram_fit(data x, data y, lb, ub);
% ----- to do -----
parameter=f_variogram_fit(x,y,lb,ub);
% Kriging prediction.
% Hint: Kriging prediction = f_predictkrige(data x, parameter);
% ----- to do -----
[y_krige,sigma]=f_predictkrige(x, parameter);
% Plot the kriging average in the interval [0,2].
% ----- to do -----
plot(x,y_krige,'g')
%% Step 3: Estimate error (known model)
% figure(2);
y_origin = (1.7*x.^5-6.2*x.^4+6.3*x.^3-2.3*x+1.1);
plot(x,y_origin,'b--')
legend('y data','y krige','y origin')
hold off
% Estimate error 
% ----- to do -----
err=abs(y_origin-y_krige)./y_origin*100;
% Plot error with respect to x  
% ----- to do -----
figure(2);
plot(x,err,'.')
%% Step 4: Estimate error (unknown model, leave one out)
% Leave one out: Take out the 1 sample, and model through the remaining n-1 data.
% Generate 200 models.
error=zeros(200,1);
for i = 1:size(y,1) 
    % Take out the ith sample.
    % ----- to do -----
    if i==1
        y_estimate=y(2:200);
        x_estimate=x(2:200);
    elseif i==200
        y_estimate=y(1:199);
        x_estimate=x(1:199);
    else
        y_estimate=[y(1:i-1) ; y(i+1:200)];
        x_estimate=[x(1:i-1) ; x(i+1:200)];
    end
    % Modeling through the remaining 199 data. (similar Step 2)
    % ----- to do -----
    parameter=f_variogram_fit(x_estimate,y_estimate,lb,ub);
    [y_est_krige,sigma]=f_predictkrige(x, parameter);
    % Estimate error between model prediction and provided data 
    % ----- to do -----
    error(i)=abs(y_est_krige(i)-y(i))/y(i)*100;
end
% Polt error with respect to each model 
 % ----- to do -----
 figure(3)
 plot(x,error,'b.')
 figure(4)
 histogram(error)