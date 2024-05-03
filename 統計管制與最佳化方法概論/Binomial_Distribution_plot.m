space=1000;
n=2805962;
p=4.41845e-05;
x=0:space:n;
b=zeros(1,fix(n/space)+1);
for ii=1:fix(n/space)+1
    b(ii)=nchoosek(n,x(ii))*p^x(ii)*(1-p)^(n-x(ii));
end