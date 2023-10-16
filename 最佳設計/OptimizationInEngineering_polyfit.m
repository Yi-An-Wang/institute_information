%% Example: polyfit - Fit Polynomial to Set of Point
clc; clear; close all;
% Create a vector of 5 equally spaced points in the interval [0,1], and evaluate y(x)=1/(1+x) at those points.
x = linspace(0,1,5);
y = 1./(1+x);

% Fit a polynomial of degree 4 to the 5 points.
% In general, for n points, you can fit a polynomial of degree n-1 to exactly pass through the points.
p = polyfit(x,y,4);

% Evaluate the original function and the polynomial fit on a finer grid of points between 0 and 2.
x1 = linspace(0,2);
y1 = 1./(1+x1);
f1 = polyval(p,x1);

% Plot the function values and the polynomial fit in the wider interval [0,2], with the points used to obtain the polynomial fit highlighted as circles. 
% The polynomial fit is good in the original [0,1] interval, but quickly diverges from the fitted function outside of that interval.
figure
plot(x,y,'o')
hold on
plot(x1,y1)
plot(x1,f1,'r--')
legend('y','y1','f1')