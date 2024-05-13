function [t,d_min,exitflag]=find_d_min(phi,v,p_B,v_B)
obj=@(t) obj_function1(t,phi,v,p_B,v_B);
t0=0;
A=-1;
b=0;
[t,d_sqr,exitflag]=fmincon(obj,t0,A,b);
d_min=d_sqr^0.5;