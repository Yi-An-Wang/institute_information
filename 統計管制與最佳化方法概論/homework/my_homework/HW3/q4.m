Binomial_1=xlsread("hw_3.xlsx",4,'C3:C4');
mean1=0.4; variance1=0.24;
standd1=variance1^0.5;
Binomial_5=xlsread("hw_3.xlsx",4,'E3:E8');
mean5=2; variance5=1.2;
standd5=variance5^0.5;
Binomial_20=xlsread("hw_3.xlsx",4,'G3:G23');
mean20=8; variance20=4.8;
standd20=variance20^0.5;
Binomial_50=xlsread("hw_3.xlsx",4,'I3:I53');
mean50=20; variance50=12;
standd50=variance50^0.5;
Binomial_100=xlsread("hw_3.xlsx",4,'K3:K103');
mean100=40; variance100=24;
standd100=variance100^0.5;
X1=linspace(0,1,1*10+1);
X5=linspace(0,5,5*10+1);
X20=linspace(0,20,20*10+1);
X50=linspace(0,50,50*10+1);
X100=linspace(0,100,100*10+1);
Norm_dis1=1/(standd1*(2*pi)^0.5)*exp(-((X1-mean1)/standd1).^2/2);
Norm_dis5=1/(standd5*(2*pi)^0.5)*exp(-((X5-mean5)/standd5).^2/2);
Norm_dis20=1/(standd20*(2*pi)^0.5)*exp(-((X20-mean20)/standd20).^2/2);
Norm_dis50=1/(standd50*(2*pi)^0.5)*exp(-((X50-mean50)/standd50).^2/2);
Norm_dis100=1/(standd100*(2*pi)^0.5)*exp(-((X100-mean100)/standd100).^2/2);
Bin_dis1=zeros(size(X1));
for ii=0:1
    Bin_dis1(ii*10+1)=Binomial_1(ii+1);
end
Bin_dis5=zeros(size(X5));
for ii=0:5
    Bin_dis5(ii*10+1)=Binomial_5(ii+1);
end
Bin_dis20=zeros(size(X20));
for ii=0:20
    Bin_dis20(ii*10+1)=Binomial_20(ii+1);
end
Bin_dis50=zeros(size(X50));
for ii=0:50
    Bin_dis50(ii*10+1)=Binomial_50(ii+1);
end
Bin_dis100=zeros(size(X100));
for ii=0:100
    Bin_dis100(ii*10+1)=Binomial_100(ii+1);
end
figure(1)
bar(0:0.1:1,Bin_dis1);
hold on
plot(X1,Norm_dis1)
legend('binomial distributions','normal distributions')
title("n=1 distributions")
xlabel("x")
ylabel("f(x)")
hold off

figure(2)
bar(0:0.1:5,Bin_dis5);
hold on
plot(X5,Norm_dis5)
legend('binomial distributions','normal distributions')
title("n=5 distributions")
xlabel("x")
ylabel("f(x)")
hold off

figure(3)
bar(0:0.1:20,Bin_dis20);
hold on
plot(X20,Norm_dis20)
legend('binomial distributions','normal distributions')
title("n=20 distributions")
xlabel("x")
ylabel("f(x)")
hold off

figure(4)
bar(0:0.1:50,Bin_dis50);
hold on
plot(X50,Norm_dis50)
legend('binomial distributions','normal distributions')
title("n=50 distributions")
xlabel("x")
ylabel("f(x)")
hold off

figure(5)
bar(0:0.1:100,Bin_dis100);
hold on
plot(X100,Norm_dis100)
legend('binomial distributions','normal distributions')
title("n=100 distributions")
xlabel("x")
ylabel("f(x)")
hold off