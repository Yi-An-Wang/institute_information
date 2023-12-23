function [c,ceq]=get_uncertainties_cns(x,E)

stdx=0.0052*ones(1,8);
covX=diag(stdx.^2);

std_E=1e6;
cov_E=std_E.^2;

N=10000;
RandX=mvnrnd(x, covX, N);
RandE=mvnrnd(E,cov_E,N);

c=zeros(1,27);
for ii=1:N
    [c_temp,ceq]=get_cns(RandX(ii,:),RandE(ii));
    for jj=1:27
        if c_temp(jj)>c(jj)
            c(jj)=c_temp(jj);
        end
    end
end