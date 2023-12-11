function [c_cns, ceq_cns] = compute_cns_MC(r)
    % constraints
    %
    % Args:
    %   r: radius [r1, r2]
    % Return:
    %     c: inequality contraints
    %     ceq: equality constraints

    global varR muE varE

    Num_cns = 1e6;  % sample number
    
    muR = r;
    covR = zeros(2,2);
    covR(1,1) = varR;
    covR(2,2) = varR;
    randR = mvnrnd(muR, covR, Num_cns); % random for radii
    
    covE = varE;
    randE = mvnrnd(muE, covE, Num_cns); % random for E
    
    Num_failure_cns = zeros(11, Num_cns);
    parfor i = 1:Num_cns
        [c,~] = compute_cns(randR(i, :), randE(i));
        Num_failure_cns(:,i) = (c > 0); % c>0 means violating constrains = failure
    end
    prob_failure_MC_cns = sum(Num_failure_cns, 2) / Num_cns;

    c_cns = prob_failure_MC_cns - 0.01;   % 99% reliability 
    ceq_cns = [];
end
