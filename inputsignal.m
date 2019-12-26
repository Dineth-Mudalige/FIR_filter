function X = inputsignal(samples)
global O_c1 O_c2 O_s T;
global O_1 O_2 O_3 n1;
%Component frequencies of the input
O_1 = O_c1/2;
O_2 = O_c1 + (O_c2-O_c1)/2;
O_3 = O_c2 + (O_s/2-O_c2)/2;
%Generating the discrete signal
n1 = 0:1:samples;
X = cos(O_1.*n1.*T)+cos(O_2.*n1.*T)+cos(O_3.*n1.*T);
figure;
subplot(2,1,1);
stem(n1,X);
xlabel('n');
ylabel('Amplitude');
title('Input signal(Time domain)')
subplot(2,1,2);
len_fft = 2^nextpow2(numel(n1))-1;
x_fft = fft(X,len_fft);
x_fft_plot = [abs([x_fft(len_fft/2+1:len_fft)]),abs(x_fft(1)),abs(x_fft(2:len_fft/2+1))];
f = O_s*linspace(0,1,len_fft)-O_s/2;
plot(f,x_fft_plot);
xlabel('Frequency rad/s');
ylabel('Magnitude');
title('Input signal in the frequency domain');
axis tight;