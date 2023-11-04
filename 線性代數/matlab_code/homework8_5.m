x=linspace(-pi,pi,1000);
x=x';
n=size(x,1);
y=zeros(n,1);
y_fit=pi+3*pi^2/2.*x+pi^3/3.*x.^2+3*pi^4/4.*x.^3;
for ii=1:n
    if x(ii)>=0
        judge=rem(x(ii),(2*pi));
    else
        judge=rem((abs(x(ii))+pi),(2*pi));
    end
    if (judge>=pi && judge~=0) 
        y(ii)=-1;
    elseif (judge>=0 && judge<pi)
        y(ii)=2;
    end
end
plot(x,y)
set(gca,'YLim',[-2,3]);
grid on
hold on
plot(x,y_fit)
hold off
ATA=[2*pi 0 2*pi^3/3 0; 0 2*pi^3/3 0 2*pi^5/5; 2*pi^3/3 0 2*pi^5/5 0; 0 2*pi^5/5 0 2*pi^7/7];
ATb=[pi; 3*pi^2/2; pi^3/3; 3*pi^4/4];
x_had=ATA^-1*ATb;