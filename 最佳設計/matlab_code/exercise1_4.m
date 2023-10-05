x1=-2:0.01:2;
x2=-2:0.01:2;
[X1,X2]=meshgrid(x1,x2);
Y=(X1-X2).^4+8.*X1.*X2-X1+X2+3;
g=X1.^4-2*X2.*X1.^2+X2.^2+X1.^2-2*X1;
contour(X1,X2,Y,[0 1 2 3 4 5 6 7 8 9 10],'ShowText','on')
hold on
contour(X1,X2,g,[0,0.1],'ShowText','on')
hold off