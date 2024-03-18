syms s T 
g=ilaplace(T/(2*s^3+s^2+s));
Y=subs(g,T,5);
ht=matlabFunction(Y);
t=1:0.01:100;
figure(1)
plot(t,ht(t))

gt=matlabFunction(g);
T=randi([4 5],size(t));
figure(2)
plot(t,gt(T,t))
