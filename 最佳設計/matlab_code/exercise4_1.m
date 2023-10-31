
x0=[ 1.1; 1];
x=zeros(2,4);
x(:,1)=x0;
f_sovl=zeros(4,1);
syms x1 x2
f=x1^4-2*x1^2*x2+x2^2;
f_sovl(1)=double(subs(f,[x1;x2],x0));
gx1=diff(f,x1);
gx2=diff(f,x2);
H=[diff(gx1,x1) diff(gx1,x2); diff(gx2,x1) diff(gx2,x2)];

for ii=1:3
    delt1=subs(gx1,[x1;x2],x(:,ii));
    delt2=subs(gx2,[x1;x2],x(:,ii));
    x(1,ii+1)=x(1,ii)-double(delt1);
    x(2,ii+1)=x(2,ii)-double(delt2);
    f_sovl(ii+1)=double(subs(f,[x1;x2],x(:,ii+1)));
end
