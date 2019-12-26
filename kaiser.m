function wk_nT = kaiser
global A;
global order n O_s B_t;
if A<=21
    alpha = 0;
elseif A>21 && A<=50
    alpha = 0.5842.*(A-21).^0.4+0.07886.*(A-21);
else
    alpha = 0.1102.*(A-8.7);
end
%Calculating D
if A<=21
    D = 0.9222;
else
    D = (A-7.95)/14.36;
end
%Finding the order of the filter
N = ceil((O_s*D/B_t)+1);
%Order of the filter should be odd
if mod(N,2) == 0
    order = N+1;
else
    order =N;
end
n = -(N-1)/2:1:(N-1)/2;
beta = alpha*sqrt(1-(2*n/(N-1)).^2);
%Generating Io_alpha
bessellimit = 125;
Io_alpha = 1;
for k = 1:bessellimit
    val_k = ((1/factorial(k))*(alpha/2).^k).^2;
    Io_alpha = Io_alpha + val_k;
end
%Generating Io_beta
Io_beta = 1;
for m = 1:bessellimit
    val_m = ((1/factorial(m))*(beta/2).^m).^2;
    Io_beta = Io_beta +val_m;
end
wk_nT = Io_beta/Io_alpha;
%Printing the results
fprintf('Filter order = %d',order);
%Plotting the kaiser function
figure;
stem(n,wk_nT);
xlabel('n');
ylabel('Amplitude');
title('Kaiser window(Time domain)');
    