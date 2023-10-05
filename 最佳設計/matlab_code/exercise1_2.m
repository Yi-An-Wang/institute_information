c1=5;
c2=-8;
x1=0:0.1:10;
x2=0:0.1:10;
apha=[1 2 3];
belta=[2 1 3];
gama=[0.1 0.5 0.9];
delta=[0.3 0.5 0.7];
[X1,X2]=meshgrid(x1,x2);
for ii=1:3
    Y=c1.*X1.^apha(ii).*X2.^belta(ii)+c2.*X1.^gama(ii).*X2.^delta(ii);
    contour(X1,X2,Y,0:100:1000,'ShowText','on')
hold on
end
hold off
