function h_nT = idealfilter
global O_c1 O_c2 O_s T order;
%Generates the ideal impulse response stopband filter
n_L = -(order-1)/2:1:-1;
hn_L = (1./(n_L*pi)).*(sin(O_c1*n_L*T)-sin(O_c2*n_L*T));
n_R = 1:1:(order-1)/2;
hn_R = (1./(n_R*pi)).*(sin(O_c1*n_R*T)-sin(O_c2*n_R*T));
hn_0 = 1+(2/O_s).*(O_c1-O_c2);
n = [n_L,0,n_R];
h_nT = [hn_L,hn_0,hn_R];
%Plotting the ideal filter
figure;
stem(n,h_nT,'-r');
xlabel('n');
ylabel('Amplitude');
title('Ideal Impulse stopband filter(Time domain)');
