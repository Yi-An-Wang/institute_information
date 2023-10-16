%% Example: neural network
clc; clear; close all;

% This example shows how to use a feedforward neural network to solve a simple problem.
% Load the training data.
% The 1-by-94 matrix x contains the input values and the 1-by-94 matrix t contains the associated target output values.
[x, t] = simplefit_dataset;

% Construct a feedforward network with one hidden layer of size 10.
net = feedforwardnet(10);

% Train the network net using the training data.
net = train(net, x, t);

% Estimate the targets using the trained network.
y = net(x);

% View the trained network.
view(net);

% Assess the performance of the trained network. The default performance function is mean squared error.
perf = perform(net, y, t)
