x0=[ 1; 1];
x=zeros(2,4);
x(:,1)=x0;
f_sovl=zeros(4,1);
syms x1 x2
f=4*x1^2+3*x1*x2+x2^2;
f_sovl(1)=double(subs(f,[x1;x2],x0));
gx1=diff(f,x1);
gx2=diff(f,x2);
H=[diff(gx1,x1) diff(gx1,x2); diff(gx2,x1) diff(gx2,x2)];

for ii=1:3
    delt1=double(subs(gx1,[x1;x2],x(:,ii)));
    delt2=double(subs(gx2,[x1;x2],x(:,ii)));
    H_sub=double(subs(H,[x1;x2],x(:,ii)));
    apha=H_sub^-1;
    x(:,ii+1)=x(:,ii)-apha*[delt1; delt2];
    %x(2,ii+1)=x(2,ii)-double(delt2);
    f_sovl(ii+1)=double(subs(f,[x1;x2],x(:,ii+1)));
end
x_1=linspace(-5,5);
x_2=linspace(-5,5);
[X1,X2]=meshgrid(x_1,x_2);
y=4.*X1.^2+3.*X1.*X2+X2.^2;
surf(X1,X2,y)