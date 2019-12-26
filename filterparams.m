function filterparams(index_num)
%Generates both given and derived parameters to implement the filter
global A B C;%extracts from the index number
global A_p;%max passband ripple
global A_a;%min stopband ripple
global O_p1;%lower passband edge
global O_p2;%upper passband edge
global O_a1;%lower stopband edge
global O_a2;%upper stopband edge
global O_s;%sampling frequency
%Deriving the information from the index number
A = mod(floor(index_num/100),10);
B = mod(floor(index_num/10),10);
C = mod(index_num,10);
A_p = 0.03+(0.01*A);
A_a = 45+B;
O_p1 = (C*100)+400;
O_p2 = (C*100)+950;
O_a1 = (C*100)+500;
O_a2 = (C*100)+800;
O_s = 2*((C*100)+1300);
fprintf('For the index number %d:\n.....The required parameters.....\n',index_num);
fprintf('Maximum passband ripple = %.2f\nMinimum stopband attenuation = %d\nLower passband edge = %d\n',A_p,A_a,O_p1);
fprintf('Upper passband edge = %d\nLower stopband edge = %d\nUpper stopband edge = %d\nSampling frequency = %d\n',O_p2,O_a1,O_a2,O_s);
