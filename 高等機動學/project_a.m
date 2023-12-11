[delta,a]=project_data();
syms w z th_w th_z b2 b3 b4 
M=[exp(1i*b2)-1 exp(1i*a(2))-1; exp(1i*b3)-1 exp(1i*a(3))-1; exp(1i*b4)-1 exp(1i*a(4))-1;];
W=w*exp(1i*th_w);
Z=z*exp(1i*th_z);
% Delta2=double(det([M(2,2) delta(3); M(3,2) delta(4)]));
% Delta3=double(-det([M(1,2) delta(2); M(3,2) delta(4)]));
% Delta4=double(det([M(1,2) delta(2); M(2,2) delta(3)]));
% Delta1=(-Delta4-Delta3-Delta2);
% eq1=Delta2*exp(1i*b2)+Delta3*exp(1i*b3)+Delta4*exp(1i*b4)+Delta1==0;
% result=solve(eq1,b2,b3,b4);
% double(result.b2)
eq2=M*[W; Z]==delta(2:4);
solve(eq2)