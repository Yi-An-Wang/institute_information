x1=-10:0.1:10;
x2=-10:0.1:10;
a1=[1 -2 3];
a2=[4 5 -6];
b1=[7 -8 -9];
b2=[-4 5 6];
c1=[-7 8 -9];
c2=[-5 2 -1];
a0=7;
[X1,X2]=meshgrid(x1,x2);
for ii=1:3
    Y=a0+a1(ii).*X1+a2(ii).*X2+b1(ii).*X1.^2+b2(ii).*X2.^2+c1(ii).*X1.^3+c2(ii).*X2.^3;
    contour(X1,X2,Y,'ShowText','on')
    hold on
end
hold off