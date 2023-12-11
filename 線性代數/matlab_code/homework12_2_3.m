B=[5 4; 4 5];
obj=@(x)(x'*B*x/(x'*x));
x0=[0;0];
A=[];
b=[];
x_m=fmincon(obj,x0,A,b);