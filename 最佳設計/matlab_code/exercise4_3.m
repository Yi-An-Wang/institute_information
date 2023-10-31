x0=[ 1.1; 1];
x=zeros(2,100);
x(:,1)=x0;
f_sovl=zeros(100,1);
syms x1 x2
f=x1^4-2*x1^2*x2+x2^2;
f_sovl(1)=double(subs(f,[x1;x2],x0));
gx1=diff(f,x1);
gx2=diff(f,x2);
H=[diff(gx1,x1) diff(gx1,x2); diff(gx2,x1) diff(gx2,x2)];
apha1=0.01;
for ii=1:100
    delt1=double(subs(gx1,[x1;x2],x(:,ii)));
    delt2=double(subs(gx2,[x1;x2],x(:,ii)));
    x(:,ii+1)=x(:,ii)-apha1*[delt1; delt2];
    f_sovl(ii+1)=double(subs(f,[x1;x2],x(:,ii+1)));
    if abs(f_sovl(ii+1)-f_sovl(ii))<=1e-9
        break
    end
end

x_1=linspace(-5,5);
x_2=linspace(-5,5);
[X1,X2]=meshgrid(x_1,x_2);
y=X1.^4+2.*X1.^2.*X2+X2.^2;
surf(X1,X2,y)

