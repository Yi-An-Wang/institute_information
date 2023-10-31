function x=test(a,theta,d)
syms x [3 2] matrix
for ii=1:size(d,1)
    x(ii)=[a(ii).*cos(theta(ii)); a(ii).*sin(theta(ii)); d(ii)];
end