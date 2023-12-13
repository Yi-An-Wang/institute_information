a=20*exp(-36/180*pi*1i);
b=20*exp(-108/180*pi*1i);
c=20*exp(-pi*1i);
syms d z
eq1=a+b+c+d+z==0;
eq2=abs(d)==abs(z);
eqs=[eq1 eq2];
r=solve(eqs);
%still need improve