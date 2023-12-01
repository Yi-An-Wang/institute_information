mux=[3.1139, 2.0626]; % you should change to the optimal design you obtained
stdx=[0.3, 0.3]; % you should change this value according to the homework descriptions
covX=[stdx(1)^2, 0; 0, stdx(2)^2];

% Basic MCS

N=10; % you should change this value according to the homework descriptions

percents=zeros(3,20);

for jj=1:20
    RandX=mvnrnd(mux, covX, N);
    X1=RandX(:,1);
    X2=RandX(:,2);

%Y=zeros(N,1); % you should change Y to constraints, therefore you have three different function evaluations
%Y=5*X1-3*X2;
    g1=1-X1.^2.*X2/20;
    g2=1-(X1+X2-5).^2/30-(X1-X2-12).^2/120;
    g3=1-80/(X1.^2+8.*X2+5);

    Nf(1)=sum(g1<0); % you should have three Nf values w.r.t different constraints
    Nf(2)=sum(g2<0);
    Nf(3)=sum(g3<0);
    pf=Nf./N; % you should have three pf values w.r.t different constraints

%     for ii=1:3
%         sprintf('Failure probability using MCS with %d samples is %0.5g percent ', N, pf(ii)*100) 
%     end
    
    percents(:,jj)=pf';
end

PER=string(percents*100);
CENT=repmat("%",3,20);
Result=PER+CENT;