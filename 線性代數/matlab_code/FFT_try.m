Fs = 1000; % 取樣頻率
T = 1/Fs; % 取樣間隔
L = 1000; % 信號長度
t = (0:L-1)*T; % 時間向量
f = 200; % 信號頻率
x = sin(2*pi*f*t); % 生成信號

Y = fft(x);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

frequencies = Fs*(0:(L/2))/L;

plot(frequencies, P1);
title('單邊幅值頻譜');
xlabel('頻率 (Hz)');
ylabel('幅值');