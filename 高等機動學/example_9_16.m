syms s1 s4 s3 d2
a=[0 0.5 3 2.5];
apha=[270 270 0 0];
apha=apha./180.*pi;
theta=[s1 pi s3 s4];
d=[0 d2 0 0];
T=cell(1,4);
for ii=1:4
    T{1,ii}=[cos(theta(ii)) -sin(theta(ii))*cos(apha(ii)) sin(theta(ii))*sin(apha(ii)) a(ii)*cos(theta(ii)); ...
        sin(theta(ii)) cos(theta(ii))*cos(apha(ii)) -cos(theta(ii))*sin(apha(ii)) a(ii)*sin(theta(ii)); ...
        0 sin(apha(ii)) cos(apha(ii)) d(ii); 0 0 0 1];
end
A=T{1,2}*T{1,3}*T{1,4}*T{1,1};