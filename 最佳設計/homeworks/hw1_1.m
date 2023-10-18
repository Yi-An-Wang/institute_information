x1=linspace(-10,10);
x2=linspace(-10,10);
x1=x1';
x2=x2';
[X1,X2]=meshgrid(x1,x2);
f=-X2-2.*X1.*X2+X1.^2+X2.^2-3.*X1.^2.*X2-2.*X1.^3+2.*X1.^4;
level1=[0 20 40 80 100 200 500 1000];
level2=[2000 4000 6000 8000 10000 12000 14000 16000];
figure(1)
contour(X1,X2,f,[level1 level2],'ShowText','on')
axis equal
hold on
scatter(1,1,'r*')
start_point=[(-3+10)/20 (1+10)/20];
end_point=[(-5+10)/20 (1+10)/20];
annotation('textarrow',start_point,end_point,'String','f(1,1)gradient=(-4,-4)')
title('f(x)=-x_2-2x_1x_2+x_1^2+x_2^2-x_1^2x_2-2x_1^3+2x_1^4')
xlabel X1
ylabel X2
hold off
figure(2)
surf(X1,X2,f)
hold on
scatter3(1,1,-4,'r*')
hold off