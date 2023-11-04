x0=[1;1];
max_step=100;
iteration_x=zeros(2,max_step);
iteration_f=zeros(1,max_step);
iteration_x(:,1)=x0;
for ii=1:max_step
    [iteration_f(ii),df,H]=objective_function_hw2_2(iteration_x(:,ii));
    if ii>1 && abs(iteration_f(ii)-iteration_f(ii-1))<1e-4 || ii==max_step
        f=iteration_f(ii);
        x=iteration_x(:,ii);
        fprintf("steps = %d \n", ii-1)
        fprintf("f = %s \n",f)
        fprintf("x1 = %s , x2 = %s \n",x(1),x(2))
        break
    end
    iteration_x(:,ii+1)=iteration_x(:,ii)-df;
end