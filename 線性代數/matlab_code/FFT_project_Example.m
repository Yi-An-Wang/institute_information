clear 
clc
delt_t=0.0001; % set Delta t
t_h=1.2345; % set time horizon
t=0:delt_t:t_h;
t=t';
freq_1=500; % set frequence 1 (unti: Hz)
freq_2=4730; % set frequence 2 (unti: Hz)
a=[1; 1];
b=[0; 0];
s1=a(1)*sin(freq_1*2*pi*t)+b(1)*cos(freq_1*2*pi*t); % set the magnitude and phase of s1
s2=a(2)*sin(freq_2*2*pi*t)+b(2)*cos(freq_2*2*pi*t); % set the magnitude and phase of s1
f_pure=s1+s2; % creat a set of sample points of clean signal
f=f_pure+ 1.5*randn(size(t)); % add some noize into the sample points

%% FFT
N=size(t,1);
f_hat=fft(f,N);
f_hat_shift=fftshift (f_hat);

%% signal analysis
k=-N/2:N/2-1;
F_k=k/(N*delt_t);
sig=(sum(F_k>0)+1)+1:size(F_k,2);
mgt=abs(f_hat_shift)/(N/2);
subplot(3,1,1)
plot(t,f,'k','lineWidth',0.1)
hold on
plot(t,f_pure,'r','LineWidth',0.5)
set(gca,'XLim',[0,t_h]);
legend('Noisy','Pure')
title Signal
xlabel time(second)
ylabel Amplitude
hold off
subplot(3,1,2)
plot(F_k(sig),mgt(sig))
title FrequencyDomain
ylabel PowerMagnitude
xlabel Frequency

%% denoise signal
valve=0.5;
f_true=f_hat.*(abs(f_hat)/(N/2)>valve);
f_filt=ifft(f_true);
subplot(3,1,3);
plot(t,f_filt)
set(gca,'XLim',[0,t_h],'YLim',[-5,5]);
title Filter
ylabel Amplitude
xlabel time(second)
