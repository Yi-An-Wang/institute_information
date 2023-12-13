syms x
A=[exp((-x^2-x+1))*1i 1; exp(x*1i) 1];
X=[1i; -1];
b=[(4/5+3/4)*1i; (1/2^(1/2)-1/2^(1/2))*1i];
eq=A*X==b;
r=solve(eq,x);
% this not work