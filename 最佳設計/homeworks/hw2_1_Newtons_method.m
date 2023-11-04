x0=[1;1;1];
max_step=100;
iteration_x=zeros(3,max_step);
iteration_f=zeros(1,max_step);
iteration_x(:,1)=x0;
f=0;
x=zeros(3,1);
for ii=1:max_step
    [iteration_f(ii),df,H]=objective_function_hw2_1(iteration_x(:,ii));
    if ii>1 && abs(iteration_f(ii)-iteration_f(ii-1))<1e-4 || ii==max_step
        f=iteration_f(ii);
        x=iteration_x(:,ii);
        fprintf("f = %s \n",f)
        fprintf("x1 = %s , x2 = %s , x3 = %s \n",x(1),x(2),x(3))
        break
    end
    iteration_x(:,ii+1)=iteration_x(:,ii)-det(H^-1)*df;
end