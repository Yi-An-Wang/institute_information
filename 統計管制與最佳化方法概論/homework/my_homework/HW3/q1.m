pdf=zeros(3,999);
cdf=zeros(3,1000);
b=[5 8 13];
X=zeros(3,999);
for ii=1:3
    x=linspace(0,b(ii),1000);
    P=q1_pdf(x,b(ii));
    cdf(ii,:)=q1_cdf(x,b(ii)); % parameter=b(ii)
    cdf(ii,1)=0;
    P(1)=[];
    x(1)=[];
    X(ii,:)=x;
    pdf(ii,:)=P;
end

figure(1)
for ii=1:3
    plot(X(ii,:),pdf(ii,:))
    grid on
    hold on
end
title('p.d.f')
xlabel('x');
ylabel('f(x;b)')
legend('b=5','b=8','b=13');
hold off

figure(2)
for ii=1:3
    plot([0 X(ii,:)],cdf(ii,:))
    grid on
    hold on
end
title('c.d.f')
xlabel('x');
ylabel('F(x;b)')
legend('b=5','b=8','b=13');
hold off