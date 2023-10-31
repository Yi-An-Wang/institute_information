function [Jacobian,J,T]=transformation(a,apha,theta,d)   %   please arrange variables into columns 

n=size(d,1);
T=cell(n,2);    
%   1st column of T is local transformation for Zi to Zi-1
%   2st column of T is global transformation for Zi to fix roigin fram
J=cell(n,3);
%   1st column of J is Ji for Jacobian
%   2st column of J is z(i-1) for Jacobian
%   3st column of J is p(i-1) for Jacobian
for ii=1:n
    T(ii,1)={[cos(theta(ii)) -sin(theta(ii)).*cos(apha(ii)) sin(theta(ii)).*sin(apha(ii)) a(ii).*cos(theta(ii));...
    sin(theta(ii)) cos(theta(ii)).*cos(apha(ii)) -cos(theta(ii)).*sin(apha(ii)) a(ii).*sin(theta(ii));...
    0 sin(apha(ii)) cos(apha(ii)) d(ii); 0 0 0 1]};
end
for ii=1:n
    T{ii,2}=1;
end
for ii=1:n
    for jj=1:ii
        T{ii,2}=T{ii,2}*T{jj,1};
    end
end

for ii=1:n-1
    J{ii+1,2}=T{ii,2}(1:3,1:3)*[0; 0; 1];
end
J{1,2}=[0; 0; 1];

r=[a'.*cos(theta'); a'.*sin(theta'); d'];

for ii=1:n
    if ii==1
        J{n+1-ii,3}=T{n-ii,2}(1:3,1:3)*r(:,n+1-ii);
    elseif n-ii>0
        J{n+1-ii,3}=T{n-ii,2}(1:3,1:3)*r(:,n+1-ii)+J{n+2-ii,3};
    else
        J{1,3}=r(:,n+1-ii)+J{n+2-ii,3};
    end
end

for ii=1:n
    J{ii,1}=[cross(J{ii,2},J{ii,3}); J{ii,2}];
end

Jacobian=J{1,1};
if n>=2
    for ii=2:n
        Jacobian=[Jacobian J{ii,1}];
    end
end