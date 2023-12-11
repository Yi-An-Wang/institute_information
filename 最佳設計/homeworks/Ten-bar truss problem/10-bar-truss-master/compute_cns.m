function [c, ceq] = compute_cns(r, E)
    % constraints for fmincom
    %
    % Args:
    %   r: radius [r1, r2]
    %  E: young's modulus
    % Return:
    %     c: inequality contraints
    %     ceq: equality constraints

    [stress_all, Q_all] = ten_bar_model(r, E);

    yield_stress = 250e+6;
    disp_limit = 0.02;

    c1 = (abs(stress_all) - yield_stress) ./ 1e+6;  % 1e+6 for normalization
    c2 = sqrt(Q_all(3)^2.0 + Q_all(4)^2.0) - disp_limit;
    c = [c1; c2];
    ceq = [];
end
