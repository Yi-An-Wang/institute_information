x1=linspace(-15,-14);
x2=linspace(300,330);
x1=x1';
x2=x2';
[X1,X2]=meshgrid(x1,x2);
f=-X2-2.*X1.*X2+X1.^2+X2.^2-3.*X1.^2.*X2-2.*X1.^3+2.*X1.^4;
value=[3901 3910 3950 4000 4100 4500 4800 5000];
contour3(X1,X2,f,value,'ShowText','on')
xlabel X1
ylabel X2