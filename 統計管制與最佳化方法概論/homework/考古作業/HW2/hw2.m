close all
x = 0:20;
y = binopdf(x,10,0.3);
plot(x,y)
hold on

x = 0:20;
y = binopdf(x,30,0.1);
plot(x,y,'--')
hold on

x = 0:20;
y = binopdf(x,100,0.03);
plot(x,y,'-o')
hold on

x = 0:20;
y = binopdf(x,500,0.006);
plot(x,y,'-.')
hold on

x = 0:20;
y = binopdf(x,1000,0.003);
plot(x,y,'-*')
hold on

x = 0:20;
y = poisspdf(x,3);
plot(x,y,'--','linewidth',5)
hold on

legend('(n,p)=(10,0.3)','(n,p)=(30,0.1)','(n,p)=(100,0.03)','(n,p)=(500,0.006)','(n,p)=(1000,0.003)','\lambda =3')