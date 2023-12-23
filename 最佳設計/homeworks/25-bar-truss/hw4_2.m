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

mux=x; % you should change to the optimal design you obtained
stdx=0.0052*ones(1,8); % you should change this value according to the homework descriptions
covX=diag(stdx.^2);

std_E=1e6;
cov_E=std_E.^2;

% Basic MCS

N=1e6;
RandX=mvnrnd(mux, covX, N);
RandE=mvnrnd(E,cov_E,N);

g=zeros(N,27);
for ii=1:N
    [c,ceq]=get_cns(RandX(ii,:),RandE(ii));
    g(ii,:)=c;
end

Nf=zeros(1,27);
for ii=1:27
    Nf(ii)=sum(g(:,ii)>0);
end
pf=Nf/N;

for ii=1:27
    sprintf('Failure probability using MCS with number %d constraint is %0.5g percent ', ii, pf(ii)*100) 
end
bar(pf*100);
xlabel ConstraintNumber
ylabel ViolatingPercentage
ax=gca;
ax.YLim=[-10,100];
