p_A = [6.7; 1.5];
p_B = [5.4,; 7.8];
r = 3.5;
d_v = p_B - p_A;
theta = asin(r/norm(d_v));

x = linspace(-15,10);
y = linspace(-10,15);
Z = zeros(100,100);

for ii = 1:100
    for jj = 1:100
        v_p = [x(ii); y(jj)];
        v_v = v_p - p_A;
        Z(jj,ii) = 100 * (v_v' * d_v)/(norm(v_v)*norm(d_v)) - cos(theta);
    end
end

[X,Y] = meshgrid(x,y);
figure(1)
surf(X,Y,Z)
figure(2)
contour(X,Y,Z,10)