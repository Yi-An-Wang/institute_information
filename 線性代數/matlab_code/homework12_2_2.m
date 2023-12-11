x=linspace(-100,100,101);
y=linspace(-100,100,101);
[X,Y]=meshgrid(x,y);
P=0.5.*X.^2-3.*Y;
surf(X,Y,P);