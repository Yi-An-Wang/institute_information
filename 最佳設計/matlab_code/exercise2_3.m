x1=linspace(-10,10,500);
x2=linspace(-10,10,500);
x1=x1';
x2=x2';
[X1,X2]=meshgrid(x1,x2);
f=100.*(X2-X1.^2).^2+(1-X1)^2;
f1=X1-X2;
s1=0:100:1000;
s2=10000:10000:500000;
S=[s1 s2];
contour3(X1,X2,f1,50,'ShowText','on')
hold on
g1=2*X1+3*X2-10;
g2=-5*X1-2*X2+2;
g3=-2*X1+7*X2-8;
contour3(X1,X2,g1,0:10:100,'ShowText','on')
contour3(X1,X2,g2,50,'ShowText','on')
contour3(X1,X2,g3,50,'ShowText','on')
xlabel('X1')
ylabel('X2')