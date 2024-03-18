syms s T 
g=ilaplace(T/(2*s^3+s^2+s));
Y=subs(g,T,5);
ht=matlabFunction(Y);
t=1:0.01:100;
plot(t,ht(t))
