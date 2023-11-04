function [f,df,H]=objective_function_hw2_2(x)
f=2*x(1)^2-3*x(1)*x(2)+8*x(2)^2+x(1)-x(2);
df=zeros(2,1); 
df(1)=4*x(1)-3*x(2)+1;
df(2)=-3*x(1)+16*x(2)-1;
H=[4 -3; -3 16];