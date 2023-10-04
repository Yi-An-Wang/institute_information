function P=characteristic_polynomial(A)
syms x
E=x*eye(size(A,1))-A;
P=det(E);