% -- 25-bar truss optimization
% -- Units: in-lb-s-lbf-psi

clear
close
clc

E=1e7;
x0 = 1.0*ones(1,8);
lb = 0.1*ones(1,8);
ub = 5.0*ones(1,8);
options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'active-set');

[x, fval, exitflag] = fmincon('get_obj', x0, [], [], [], [], lb, ub, @(x) get_cns(x,E), options);
