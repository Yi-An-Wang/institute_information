function [f2_str,f1_x2_str,x2_str]=f1_value_at_x2_star()
fun=@HW3_objective2;
x0=[5;5];
A=[];
b=[];
Aeq=[];
beq=[];
lb=[0;0];
ub=[10;10];
nonlcon=@HW3_constrain;
[x2_str,f2_str]=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon);
f1_x2_str=HW3_objective1(x2_str);