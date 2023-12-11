% -- Ten-bar truss optimization
% -- Units: m-kg-s-N-Pa

close all
clear
clc

% -- globals

global varR muE varE

E = 200e9;  % young's modulus
length = 9.14;  % default lenght of element
varR = 0.0052; % variance of radii
muE = 200e9;  % mean of young's modulus
varE = 200e8;  % variance of young's modulus

% -- start optimization

x0 = [0.01, 0.01];
lb = [0.001, 0.001];
ub = [0.5, 0.5];

options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'active-set');
options.MaxFunctionEvaluations = 8.000000e+05;
options.MaxIterations = 4.0e+5;
[radii, fval, exitflag] = fmincon('get_obj', x0, [], [], [], [], lb, ub, @(radii)compute_cns_FOSM(radii), options);
% [radii, fval, exitflag] = fmincon('get_obj', x0, [], [], [], [], lb, ub, @(radii)compute_cns_MC(radii), options);

% -- identify active constraints

[c_opt,~] = compute_cns(radii, E);
active = c_opt > 0;

% -- uncertainty analysis by Monte-Carlo simulation

Num = 1e6;  % sample number

muR = radii;
covR = zeros(2,2);
covR(1,1) = varR;
covR(2,2) = varR;
randR = mvnrnd(muR, covR, Num); % random for radii

covE = varE;
randE = mvnrnd(muE, covE, Num); % random for E

Num_failure = zeros(11, Num);
parfor i = 1:Num
    [c,~] = compute_cns(randR(i, :), randE(i));
    Num_failure(:,i) = (c > 0); % c>0 means violating constrains = failure
end
prob_failure_MC = sum(Num_failure, 2) / Num;
prob_MC = 1 - prob_failure_MC;