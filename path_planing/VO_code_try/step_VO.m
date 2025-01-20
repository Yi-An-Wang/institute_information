p_A = [0; 0];
p_B = [0; 121];
p_B_list = [zeros(1, 1000); linspace(0, 400, 1000)];
r = 120; 
tau = 2;
v_unc = 0.0;
inflate = 1.0;

% x_list = linspace(-100, 100, 1000);
y_list = zeros(1,1000);
% for ii = 1:1000
%     y_list(ii) = VO_func(x_list(ii), p_A, p_B, r, tau, v_unc, inflate);
% end

x = 40;
for ii = 1:1000
    y_list(ii) = VO_func(x, p_A, p_B_list(:,ii), r, tau, v_unc, inflate);
end
figure(1)
plot(linspace(0, 400, 1000), y_list)
axis equal
grid on

function y = VO_func(x, p_A, p_B, r, tau, v_unc, inflate)
distance = norm(p_B - p_A);
k = distance / tau;
r_prompt = r / tau;
if distance > r
    sin_theta = r / distance;
    cos_theta = sqrt(1 - sin_theta^2);
    LR_matrix = [sin_theta cos_theta; -cos_theta sin_theta];
    RR_matrix = [sin_theta -cos_theta; cos_theta sin_theta];
    q_L = LR_matrix * [0; -1];
    q_R = RR_matrix * [0; -1];
    Q_L = (q_L * r_prompt + v_unc) * inflate + [0; k];
    Q_R = (q_R * r_prompt + v_unc) * inflate + [0; k];
    xL = Q_L(1);
    xR = Q_R(1);
    mL = -q_L(1)/q_L(2);
    mR = -q_R(1)/q_R(2);
    cL = Q_L(2) - mL * Q_L(1);
    cR = Q_R(2) - mR * Q_R(1);

    y = f_side(x, mL, cL) * sig_L(x, xL) + f_middle(x, k, r_prompt) * sig_M(x, xL, xR) + f_side(x, mR, cR) * sig_R(x, xR);
else
    y = k - (r_prompt + v_unc) * inflate;
end
end

function y = f_side(x, m, c)
y = m * x + c;
end

function y = f_middle(x, k, r)
y = k - (abs(r^2 - x.^2)).^(0.5);
end

function y = sig_L(x, x_p)
kc = 20;
if kc * (x - x_p) < 700
    n = kc * (x - x_p);
else
    n = 700;
end
y = 1 / (1 + exp(n));
end

function y = sig_R(x, x_p)
kc = 20;
if kc * (x - x_p) > -700
    n = -kc * (x - x_p);
else
    n = 700;
end
y = 1 / (1 + exp(n));
end

function y = sig_M(x, x_L, x_R)
kc = 20;
if kc * (x - x_R) < 700
    n_R = kc * (x - x_R);
else
    n_R = 700;
end
if kc * (x - x_L) > -700
    n_L = -kc * (x - x_L);
else
    n_L = 700;
end
y = 1 / (1 + exp(n_L)) + 1 / (1 + exp(n_R)) - 1;
end
