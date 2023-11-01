x0=[1;1;1];
max_step=100;
iteration_x=zeros(3,max_step);
iteration_f=zeros(1,max_step);
iteration_x(:,1)=x0;
for ii=1:max_step
    [iteration_f(ii),df,H]=objective_function_hw2_1(iteration_x(:,ii));
    if ii>1 && abs(iteration_f(ii)-iteration_f(ii-1))<1e-3 || ii==max_step
        break
    end
    iteration_x(:,ii+1)=iteration_x(:,ii)-0.1*df;
end