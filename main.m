close all;
clear all;
clc;
global n order O_s O_c1 O_c2 T;
global O_1 O_3 n1;
%Generating the given filter parameters
filterparams(170401);
%Generating the derived filter parameters
deriveparams;
%Generating the kaiser window
wk_nT = kaiser;
%Obtaining the ideal impulse stopband filter
h_nT = idealfilter;
%Obtaining the noncausal stopband filter
hw_nT = h_nT.*wk_nT;
%Plotting the noncausal stopband filter
figure;
stem(n,hw_nT);
xlabel('n');
ylabel('Amplitude');
title('Noncausal stopband filter window(Time domain)');
%Question 2
%Plotting the causal stopband filter
n_shifted = [0:1:order-1]; 
figure;
stem(n_shifted,hw_nT);
xlabel('n');
ylabel('Amplitude');
title('Causal Impulse Response filter(Time Domain)');
%obtaining the frequency domain impulse response response
fvtool(hw_nT);
%Question 3
[Hw,f] = freqz(hw_nT);%obtaining the frequency response and corresponding frequencies
w = f*O_s/(2*pi);%Angular frequency
log_Hw = 20.*log10(abs(Hw));
figure;
plot(w,log_Hw);
xlabel('Angular frequency(rad/s)');
ylabel('Magnitude(dB)');
title('Magnitude response of the filter(Frequency domain)');
%Question 4
%Plotting the magnitude response of the passbands
%considering the lower passband
figure;
finish = round((length(w)/(O_s/2)*O_c1));
wpass_l = w(1:finish);
hpass_l = log_Hw(1:finish);
plot(wpass_l,hpass_l);
axis([-inf, inf, -0.1, 0.1]);
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
title('Magnitude response of Lower Passband - Frequency Domain');
%Considering the upperpassband
figure; 
start = round(length(w)/(O_s/2)*O_c2); 
wpass_h = w(start:length(w));
hpass_h = log_Hw(start:length(w));
plot(wpass_h,hpass_h);
axis([-inf, inf, -0.1, 0.1]);
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
title('Magnitude response of the Upper Passband - Frequency Domain');
%Question 5
%Generating the input of desired number samples
X = inputsignal(600);
%Question 6
% Filtering using frequency domain multiplication
len_fft = length(X)+length(hw_nT)-1; % length for fft in x dimension
x_fft = fft(X,len_fft);
hw_nT_fft = fft(hw_nT,len_fft);
out_fft = hw_nT_fft.*x_fft;
out = ifft(out_fft,len_fft);
rec_out = out(floor(order/2)+1:length(out)-floor(order/2)); 
% Ideal Output Signal 
ideal_out = cos(O_1.*n1.*T)+cos(O_3.*n1.*T);
%O_2 is left out because it is in the  stopband
%Obtaining the output waveforms
% Frequency domain representation of output signal after filtering using
% the designed filter
figure;
subplot(2,1,1);
len_fft = 2^nextpow2(numel(n1))-1;
xfft_out = fft(rec_out,len_fft);
x_fft_out_plot = [abs([xfft_out(len_fft/2+1:len_fft)]),abs(xfft_out(1)),abs(xfft_out(2:len_fft/2+1))];
f = O_s*linspace(0,1,len_fft)-O_s/2;
plot(f,x_fft_out_plot);
xlabel('Frequency rad/s');
ylabel('Magnitude');
title('Output signal of the designed filter in the frequency domain'); 
% Time domain representation of output signal after filtering using the
% designed filter
subplot(2,1,2);
stem(n1,rec_out);
xlabel('n');
ylabel('Amplitude');
title('Output signal of the designed filter in the time domain'); 
%Obtaining the outputs of the ideal filter
figure;
subplot(2,1,1);
xfft_outideal = fft(ideal_out,len_fft);
x_fft_outideal_plot = [abs([xfft_outideal(len_fft/2+1:len_fft)]),abs(xfft_outideal(1)),abs(xfft_outideal(2:len_fft/2+1))];
plot(f,x_fft_outideal_plot);
xlabel('Frequency rad/s');
ylabel('Magnitude');
title('Output signal of the ideal filter in the frequency domain'); 
% Time domain representation of output signal after filtering using ideal filter
subplot(2,1,2);
stem(n1,ideal_out);
xlabel('n');
ylabel('Amplitude');
title('Output signal of the ideal filter in the time domain'); 
%Obtaining the RMSE between the output of the outputs of the designed and
%ideal filters
RMSE = sqrt(mean((rec_out - ideal_out).^2));
deviation = abs(rec_out-ideal_out);
figure;
plot(n1,deviation,'-r');
xlabel('n');
ylabel('Magnitude');
title('Deviation between ideal and designed filters'); 
fprintf('The root mean square error between the ideal and designed filters = %.5f\n',RMSE);