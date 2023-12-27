dt = .001;
t = 0:dt:1;
frq_1=100; % unit: Hz
frq_2=120; % unit: Hz
f_pure = sin(2*pi*frq_1*t) + sin(2*pi*frq_2*t); % Sum of 2 frequencies
f = f_pure + 2.5*randn(size(t)); % Add some noise
%% Compute the Fast Fourier Transform FFT
n = length(t);
f_hat = fft(f,n); % Compute the fast Fourier transform
PSD = f_hat.*conj(f_hat)/n; % Power spectrum (power per freq)
freq = 1/(dt*n)*(0:n); % Create x-axis of frequencies in Hz
L = 1:1001; % Only plot the first half of freqs
%% Use the PSD to filter out noise
indices = PSD>100; % Find all freqs with large power
PSDclean = PSD.*indices; % Zero out all others
f_hat = indices.*f_hat; % Zero out small Fourier coeffs. in Y
f_filt = ifft(f_hat); % Inverse FFT for filtered time signal
%% PLOTS
subplot(3,1,1)
plot(t,f,'k','LineWidth',1), hold on
plot(t,f_pure,'r','LineWidth',0.5)
legend('Noisy','Clean')
subplot(3,1,2)
plot(t,f,'k','LineWidth',1), hold on
plot(t,f_filt,'b','LineWidth',0.5)
legend('original','Filtered')
subplot(3,1,3)
plot(freq(L),PSD(L),'r','LineWidth',1.5), hold on
plot(freq(L),PSDclean(L),'-b','LineWidth',1.2)
legend('Noisy','Filtered')