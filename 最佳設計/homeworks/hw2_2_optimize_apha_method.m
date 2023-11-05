x0=[1;1];
max_step=100;
iteration_x=zeros(2,max_step);
iteration_f=zeros(1,max_step);
iteration_apha=zeros(2,max_step);
iteration_x(:,1)=x0;
a1=linspace(0,1,1000);
a2=linspace(0,1,1000);
n=size(a1,2);
try_apha=cell(n,n);
for aa=1:n
    for bb=1:n
        try_apha{aa,bb}=[a1(aa); a2(bb)];
    end
end
for ii=1:max_step
    [iteration_f(ii),df,H]=objective_function_hw2_2(iteration_x(:,ii));
    if ii>1 && abs(iteration_f(ii)-iteration_f(ii-1))<1e-15 || ii==max_step
        f=iteration_f(ii);
        x=iteration_x(:,ii);
        fprintf("steps = %d \n", ii-1)
        fprintf("f = %s \n",f)
        fprintf("x1 = %s , x2 = %s \n",x(1),x(2))
        break
    end
    for jj=1:n*n
        try_x=iteration_x(ii)-try_apha{jj}.*df;
        try_f=objective_function_hw2_2(try_x);
        if jj==1
            step_f=try_f;
            iteration_apha(:,ii)=try_apha{jj};
        elseif jj>1 && try_f<step_f
            step_f=try_f;
            iteration_apha(:,ii)=try_apha{jj};
        end
    end
    iteration_x(:,ii+1)=iteration_x(:,ii)-iteration_apha(:,ii).*df;
end
