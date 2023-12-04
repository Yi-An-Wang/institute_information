[f1_str,f2_x1_str,x1_str]=f2_value_at_x1_star();
[f2_str,f1_x2_str,x2_str]=f1_value_at_x2_star();
f1=[f1_str,f1_x2_str,f1_str];
f2=[f2_x1_str,f2_str,f2_str];
figure(1)
scatter(f1,f2);
hold on
text(f1_str,f2_str+2,"Utopia")

N=10;
f1i=zeros(1,N);
for ii=1:N
    if ii==1
        f1i(1)=f1_str+(f1_x2_str-f1_str)/N;
    else
        f1i(ii)=f1i(ii-1)+(f1_x2_str-f1_str)/N;
    end
end

f2i=zeros(1,N);
optima_x=zeros(2,N);
for ii=1:N
    fun=@ex6_objective2;
    x0=[5;5];
    A=[1,1];
    b=f1i(ii);
    Aeq=[];
    beq=[];
    lb=[0;0];
    ub=[10;10];
    nonlcon=@constrain_1;
    [optima_x(:,ii),f2i(ii)]=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon);
end

scatter(f1i,f2i);
grid on
xlabel f1
ylabel f2
hold off

figure(2)
scatter([x1_str(1) optima_x(1,:)],[x1_str(2) optima_x(2,:)])