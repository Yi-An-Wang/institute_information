x1=linspace(-6*pi,6*pi);
x2=linspace(-6*pi,6*pi);
[X1,X2]=meshgrid(x1,x2);
f=20+(X1.^2-10*cos(2*pi.*X1))+(X2.^2-10*cos(2*pi.*X2));
surf(X1,X2,f)