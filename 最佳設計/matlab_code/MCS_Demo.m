clear all

mux=[5,7]; % you should change to the optimal design you obtained
stdx=[2, 0.3]; % you should change this value according to the homework descriptions
covX=[stdx(1)^2, 0; 0, stdx(2)^2];

% Basic MCS

N=100; % you should change this value according to the homework descriptions

RandX=mvnrnd(mux, covX, N);
X1=RandX(:,1);
X2=RandX(:,2);

%Y=zeros(N,1); % you should change Y to constraints, therefore you have three different function evaluations
%Y=5*X1-3*X2;
Y=X1.^2+8*X2-75;

Nf=sum(Y>0); % you should have three Nf values w.r.t different constraints
pf=Nf/N; % you should have three pf values w.r.t different constraints


sprintf('Failure probability using MCS with %d samples is %0.5g percent ', N, pf*100) 
