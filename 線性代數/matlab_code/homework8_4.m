x=linspace(-3*pi,3*pi,1000);
x=x';
n=size(x,1);
y=zeros(n,1);
y_fit=zeros(n,10);
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
% y_fit1=1/2+6/pi.*sin(x);
% y_fit2=1/2+6/pi.*sin(x)+2/pi.*sin(3.*x);
% y_fit3=1/2+6/pi.*sin(x)+2/pi.*sin(3.*x)+6/(5*pi).*sin(5.*x);
for ii=1:10
    k=ii*2-1;
    if ii==1
        y_fit(:,ii)=1/2+6/pi.*sin(x);
    else
        y_fit(:,ii)=y_fit(:,ii-1)+6/(k*pi).*sin(k.*x);
    end
    plot(x,y_fit(:,ii))
end
% plot(x,y_fit1)
% plot(x,y_fit2)
% plot(x,y_fit3)
hold off