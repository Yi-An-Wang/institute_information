x1=linspace(-1,1);
x2=linspace(-1,1);
[X1,X2]=meshgrid(x1,x2);
y_hat=90+10*X1-15*X2+5*X1.*X2;
figure(1)
surf(X1,X2,y_hat)
xlabel("x_1")
ylabel("x_2")
zlabel("y hat")
figure(2)
contour(X1,X2,y_hat,[60 70 80 85 90 100 110])
a=[0.7 0.5];
b=[0.4 0.63];
annotation("textarrow",a,b,"String","x_1=(3x_2-2)/(x_2+2)")
xlabel("x_1")
ylabel("x_2")
title("y hat")

figure(3)
gy_hat=zeros(2,100);
gx2=[1 -1];
gy_hat(1,:)=90+10*x1-15*gx2(1)+5*x1*gx2(1);
gy_hat(2,:)=90+10*x1-15*gx2(2)+5*x1*gx2(2);
plot(x1,gy_hat(1,:),x2,gy_hat(2,:))
legend("x_2=1","x_2=-1")
xlabel("x_1")
title("y hat")
grid on