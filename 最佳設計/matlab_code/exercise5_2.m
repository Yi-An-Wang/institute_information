fun=@exercise5_function;
%x0=[2;3];
A=[];
b=[];
Aeq=[];
beq=[];
ub=[5;5];
lb=[-5;-5];
[x,fval,exitflag]=ga(fun,2,A,b,Aeq,beq,lb,ub);

