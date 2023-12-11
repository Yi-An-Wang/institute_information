function [c, ceq] = compute_cns_FOSM(x)
    % constraints
    %
    % Args:
    %   r: radius [r1, r2]
    % Return:
    %     c: inequality contraints
    %     ceq: equality constraints    

    E=200e9;
    global varR muE varE

    % Obtain mean g
    [mug,~] = compute_cns(x,E);
    
    % Calculate the partial derivatives 
    delta_x=1e-5;
    mug_dx=zeros(11,2);
    for i=1:2
        temp1_x=x;
        temp2_x=x;
        temp1_x(:,i)=temp1_x(:,i)+delta_x;
        temp2_x(:,i)=temp2_x(:,i)-delta_x;
        [mug_dx_temp1,~]=compute_cns(temp1_x,E);
        [mug_dx_temp2,~]=compute_cns(temp2_x,E);
        mug_dx(:,i)=(mug_dx_temp1-mug_dx_temp2)/2/delta_x;
    end
    
    delta_E=1e-1;
    mug_dE=zeros(11,1);
    temp1_E=muE;
    temp2_E=muE;
    temp1_E=temp1_E+delta_E;
    temp2_E=temp2_E-delta_E;
    [mug_dE_temp1,~]=compute_cns(x,temp1_E);
    [mug_dE_temp2,~]=compute_cns(x,temp2_E);
    mug_dE(:,1)=(mug_dE_temp1-mug_dE_temp2)/2/delta_E;
    
    % obtain the variance g and standard deviation g
    stdx=sqrt(varR);
    stdE=sqrt(varE);
    
    varg = zeros(11,1);
    for i=1:2
        varg=varg+mug_dx(:,i).^2.*stdx^2;
    end
    varg=varg+mug_dE(:,1).^2.*stdE^2;
    
    stdg=varg.^0.5;
    
    % FOSM
    z=(0-mug)./stdg;
    p_FOSM=normcdf(z);
    pf_FOSM=1-p_FOSM;
    c=pf_FOSM-0.01;
    ceq=[];
end