[f1_str,f2_x1_str,x1_str]=f2_value_at_x1_star();
[f2_str,f1_x2_str,x2_str]=f1_value_at_x2_star();
f1=[f1_str,f1_x2_str,f1_str];
f2=[f2_x1_str,f2_str,f2_str];
scatter(f1,f2);
hold on
fi=zeros(1,10);
for ii=1:10
    if ii==1
        fi(1)=f1_str+(f1_x2_str-f1_str)/10;
    else
        fi(ii)=fi(ii-1)+(f1_x2_str-f1_str)/10;
    end
end

f2i=zeros(1,10);
feasible_x=zeros(2,10);
for ii=1:10
    fun=@ex6_objective2;
    x0=[5;5];
    A=[1,1];
    b=fi(ii);
    Aeq=[];
    beq=[];
    lb=[0;0];
    ub=[10;10];
    nonlcon=@constrain_1;
    [feasible_x(:,ii),f2i(ii)]=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon);
end

scatter(fi,f2i);
hold off