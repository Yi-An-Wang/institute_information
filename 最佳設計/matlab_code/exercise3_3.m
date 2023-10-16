x1=linspace(.3,.7);
x2=linspace(0,.2);
x1=x1';
x2=x2';
[X1,X2]=meshgrid(x1,x2);
f=100*(X2-X1.^3).^2+(1-X1).^2;
contour(X1,X2,f,'ShowText','on')
xlabel X1
ylabel X2