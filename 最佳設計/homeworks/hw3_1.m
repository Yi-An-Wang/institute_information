[f1_str,f2_x1_str,x1_str]=f2_value_at_x1_star(); % find {f^∗_2 ,f1(x^∗_2)}
[f2_str,f1_x2_str,x2_str]=f1_value_at_x2_star(); % find {f^*_1 ,f2(x^*_1)}

% plot three points
f1=[f1_str,f1_x2_str,f1_str];
f2=[f2_x1_str,f2_str,f2_str];
figure('position',[15,60,500,900])
subplot(2,1,1)
scatter(f1,f2);
axis square
hold on
text(f1_str,f2_str+2,"Utopia")

% devide (f^*_1) ~ (f2(x^∗_1)) into N points, dosen't include (f^*_1)
N=10;
f1i=zeros(1,N);
for ii=1:N
    if ii==1
        f1i(1)=f1_str+(f1_x2_str-f1_str)/N;
    else
        f1i(ii)=f1i(ii-1)+(f1_x2_str-f1_str)/N;
    end
end


% using fmincon optimize algorithm find (f_2i)
f2i=zeros(1,N);
optima_x=zeros(2,N);
for ii=1:N
    fun=@HW3_objective2;
    x0=[5;5];
    A=[1,1];
    b=f1i(ii);
    Aeq=[];
    beq=[];
    lb=[0;0];
    ub=[10;10];
    nonlcon=@HW3_constrain;
    [optima_x(:,ii),f2i(ii)]=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon);
end

% plot Pareto set 
scatter(f1i,f2i);
title ParetoSet
grid on
xlabel f_1
ylabel f_2
hold off

% plot the optima x at each Pareto set
subplot(2,1,2)
scatter([x1_str(1) optima_x(1,:)],[x1_str(2) optima_x(2,:)])
axis square
title OptimaSet
grid on
xlabel x_1
ylabel x_2