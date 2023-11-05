t_dot=[-3; 0; 1; 2];
y_dot=[2; 0; 1; 2];
t=linspace(-5,5);
t=t';
y=25/181+(61/181).*t+(57.5/181).*t.^2;
plot(t,y)
hold on
plot(t_dot,y_dot,'r*');
set(gca,'YLim',[-0.5,3]);
title("best-fit parabola")
xlabel("t")
ylabel("y")
grid on
legend('y(t)=25/181+61/181*t+57.5/181*t^2','measurments')
hold off
