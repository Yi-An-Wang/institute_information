t=linspace(-5,5);
f1=-1.9-1.2.*t;
f2=-0.9-0.2.*t-t.^2;
plot(t,f1,'r-',t,f2,'g-')
hold on
t_t=[-1; 0; 1; 2];
y_t=[-2; 0; -3; -5];
scatter(t_t,y_t);