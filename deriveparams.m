function deriveparams
%Using the required specifications
global A_p;%max passband ripple
global A_a;%min stopband ripple
global O_p1;%lower passband edge
global O_p2;%upper passband edge
global O_a1;%lower stopband edge
global O_a2;%upper stopband edge
global O_s;%sampling frequency
%specifications for filter
global B_t1;%Lower transition width
global B_t2;%Upper transistion width
global B_t;%critical transition width
global O_c1;%Lower cutoff frequency
global O_c2;%Upper cutoff frequency
global A;%Stopband attenuation
global T;%Sampling period
global Aa;%Stopband ripple
global Ap;%Passband ripple
B_t1 = O_a1-O_p1;
B_t2 = O_p2-O_a2;
B_t = min(B_t1,B_t2);
O_c1 = O_p1+(B_t/2);
O_c2 = O_p2-(B_t/2);
T = 2*pi/O_s;
dp = ((10^(0.05*A_p))-1)/(1+(10^(0.05*A_p)));
da = 10^(-0.05*A_a);
d = min(dp,da);
A = -20*log10(d);
Ap = 20*log10((1+d)/(1-d));
Aa = -20*log10(d);
fprintf('....The derived parameters......\nLower transition width=%d\nUpper transition width=%d\n',B_t1,B_t2);
fprintf('Sampling period = %.5f\n,Actual passband ripple = %.2f\nActual sideband ripple = %.2f\n',T,Ap,Aa);
fprintf('Critical transition width = %d\nLower cutoff frequency=%.2f\n',B_t,O_c1);
fprintf('Upper cutoff frequency = %.2f\nActual Stopband attenuation=%.2f\n',O_c2,A);