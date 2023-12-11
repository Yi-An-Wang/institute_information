function [stress_all, Q_all] = ten_bar_model(r, E)
    % Compute the stress of each element and the displacement of each node for 10-bar model.
    %
    % Args:
    %     r: radius [r1, r2]
    %    E: young's modulus
    % Return:
    %     stress_all: stress of 10-bar model
    %     Q_all: displacement of 10-bar model

    % -- Node location (x, y) table

    length = 9.14;  % default lenght of element
    
    nloc(1, :) = length*[2, 1];
    nloc(2, :) = length*[2, 0];
    nloc(3, :) = length*[1, 1];
    nloc(4, :) = length*[1, 0];
    nloc(5, :) = length*[0, 1];
    nloc(6, :) = length*[0, 0];

    % -- Element Connectivity Table (node i to node j)
    
    ec( 1, :) = [3, 5];
    ec( 2, :) = [1, 3];
    ec( 3, :) = [4, 6];
    ec( 4, :) = [2, 4];
    ec( 5, :) = [3, 4];
    ec( 6, :) = [1, 2];
    ec( 7, :) = [4, 5];
    ec( 8, :) = [3, 6];
    ec( 9, :) = [2, 3];
    ec(10, :) = [1, 4];
    
    % -- setup some aux. variables
    
    Le(1:10,1) = nan;  % length of each element
    cs(1:10,1) = nan;  % cos theta of each element
    ss(1:10,1) = nan;  % sin theta of each element

    for i = 1:10
        ni = ec(i, 1);
        nj = ec(i, 2);
        Le(i) = sum( (nloc(nj, :)-nloc(ni, :)).^2 ).^0.5;
        cs(i) = (nloc(ec(i,2),1)-nloc(ec(i,1),1)) / Le(i);
        ss(i) = (nloc(ec(i,2),2)-nloc(ec(i,1),2)) / Le(i);
    end
    
    % -- get total stiffness matrix
    
    k = get_total_stiffness_matrix(E, r, ec, Le, cs, ss);
    
    % -- Force
    % -- Array F is composed of the external forces applied on each node,
    % -- F = [F1x, F1y, F2x, F2y, F3x, F3y, ...]

    F = zeros(12, 1);
    F(4) = -1e7;
    F(8) = -1e7;

    % -- DOF reduction

    K_re = k(1:8, 1:8);
    F_re = F(1:8);

    % -- Get displacement

    Q_re = K_re^-1 * F_re;
    Q_all = [Q_re; zeros(4,1)];

    % -- Get stress

    stress_all = zeros(10, 1);

    for i = 1:10
        c = cs(i);
        s = ss(i);
        ni = ec(i, 1);
        nj = ec(i, 2);
        stress_all(i, 1) = get_stress_from_single_elem(E, Q_all, Le(i), c, s, ni, nj);
    end

    K_R = k(9:12,:);
    R = K_R*Q_all;
    R = [zeros(8,1); R]; % Reaction Force on node 5 and node 6
end

function k = get_total_stiffness_matrix(E, r, ec, Le, cs, ss)
    % Args:
    %    E: young's modulus
    %     r: radius [r1, r2]
    %     ec: Element Connectivity Table (node i to node j)
    %     Le: length of each element
    %     cs: cos theta of each element
    %     ss: sin theta of each element
    % Return:
    %     k: total stiffness matrix
    
    k = zeros(12,12); % stiffness matrix
    r = [r(1)*ones(6,1); r(2)*ones(4,1)]; % radius of element
    As = pi*r.^2; % area
    for i = 1:10
        c = cs(i);
        s = ss(i);
        ni = ec(i, 1); % node number i
        nj = ec(i, 2); % node number j
        k_elem = get_k_from_single_elem(E, As(i), Le(i), c, s, ni, nj);
        k = k + k_elem;
    end
end

function k = get_k_from_single_elem(E, A, L, c, s, ni, nj)
    % Args:
    %     E: young's modulus
    %     A: cross section area
    %     L: element length
    %     c: cos theta
    %     s: sin theta
    %     ni: element start from node i
    %     nj: element end to node j
    % Return:
    %     k: stiffness matrix of single element
    
    k = zeros(12, 12);
    kij = E*A/L*[c^2, c*s; c*s, s^2];
    d1 = ni*2-1; % index of dof
    d2 = ni*2;
    d3 = nj*2-1;
    d4 = nj*2;
    k(d1:d2, d1:d2) = kij;
    k(d3:d4, d3:d4) = kij;
    k(d1:d2, d3:d4) = -kij;
    k(d3:d4, d1:d2) = -kij;
end

function stress = get_stress_from_single_elem(E, Q_all, L, c, s, ni, nj)
    % Args:
    %     E: young's modulus
    %     Q: displacement matrix
    %     L: element length
    %     c: cos theta
    %     s: sin theta
    %     ni: element start from node i
    %     nj: element end to node j
    % Return:
    %     stress:
    
    d1 = ni*2-1; % index of dof
    d2 = ni*2;
    d3 = nj*2-1;
    d4 = nj*2;
    stress = E/L*[-c, -s, c, s]*[Q_all(d1), Q_all(d2), Q_all(d3), Q_all(d4)]';
end
