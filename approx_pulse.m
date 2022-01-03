% Homework Program 9
% Name: Wu, Dylan
% Date: December 2, 2021

function [coeffs,sig_approx,error] = approx_pulse(sig,n,f0)
% function that approximates the pulse train with cos functions, it returns
% the coefficents of each term, the approximation array, and the error of
% the approximation depending on a given signal, number of terms to include
% and the frequency

% initialize x
x = [];

% foor loop that adds each term according to the function
for i= 0:n
    x(:,end+1) = cos(2*pi*i*f0*(1:length(sig)));
end

% finds the coefficient matrix with matrix multiplication and the normal
% equations
coeffs = (x'*x)\(x'*sig');

% initialize sig_approx
sig_approx = zeros(1,length(sig));

% uses a for loop to add each term of the approximation
for i = 0:n
    sig_approx = sig_approx + coeffs(i+1)*cos(2*pi*i*f0*(1:length(sig)));
end

% finds the error with the given equation and matrix manipulation
error = sum((sig-sig_approx).^2);

% prints out the approximate signal
fprintf("\napproximate signal = %f", coeffs(1))

for i = 2:n+1
   fprintf(" + %f cos(2*pi*%d*f0*k)", coeffs(i), i-1)
end

% prints out the approximation error
fprintf("\n\nThe approximation error is %f\n", error)

% plots the graph
plot(sig) 
hold on;
plot(sig_approx)
xlabel("time(samples)")
ylabel("signal values(amplitude)")
title("Pulse train and a cosine wave approximation")
hold off;

end

function [pulse_train] = gen_pulse_train(off,on,cycles)
% a function that generates a pulse train with a given off and on cycle and
% the number of cycles to include

% create a temp pulse of one cycle
temp_pulse = [zeros(1,off),ones(1,on),zeros(1,off)];
% uses repmat to create the full pulse train of cylces cycles
pulse_train = repmat(temp_pulse, 1, cycles);

end

% testing the least square errors and overshoot and undershoot of the n
% from 1 to 30 with a pulse train of 50 50 4cyclces
%
% errors_matrix = []
% for i = 1:30
%    [coeffs, sig_approx, error] = approx_pulse(gen_pulse_train(50,50,4), i, 1/150);
%    errors_matrix(end+1,:) = [error, max(sig_approx-1), max(-sig_approx)];
% end
% array2table(errors_matrix, 'VariableNames', {'Least Squares Error', 'Overshoot Error', 'Undershoot Error'})

% Every third term of the approximation can be omitted wihtout increasing
% the errors eg. 3,6,9...3n where n is an integer

% The maximum overshoot and undershoot happens near the edge of the pulse
% train

% [coeffs, sig_approx, error] = approx_pulse(gen_pulse_train(50,50,4), 1, 1/150);
% 
% approximate signal = 0.333333 + -0.551248 cos(2*pi*1*f0*k)
% 
% The approximation error is 42.170934

%     Least Squares Error    Overshoot Error    Undershoot Error
%     ___________________    _______________    ________________
% 
%           42.171              -0.11542             0.21791    
%             19.4               0.16008            0.080042    
%             19.4               0.16008            0.080042    
%           13.728              0.038429             0.12636    
%           10.107               0.11145            0.079016    
%           10.107               0.11145            0.079016    
%           8.2723              0.061384              0.1114    
%           6.8741               0.10077            0.080103    
%           6.8741               0.10077            0.080103    
%           5.9888              0.069019              0.1039    
%           5.2617              0.095638            0.080495    
%           5.2617              0.095638            0.080495    
%           4.7485              0.070634            0.096522    
%           4.3097              0.093218            0.081235    
%           4.3097              0.093218            0.081235    
%           3.9799               0.07103            0.091481    
%           3.6907              0.089075            0.079352    
%           3.6907              0.089075            0.079352    
%           3.4643              0.074356            0.092079    
%           3.2625              0.082371            0.074725    
%           3.2625              0.082371            0.074725    
%           3.1002              0.067847            0.082263    
%           2.9538              0.083301            0.076323    
%           2.9538              0.083301            0.076323    
%           2.8338              0.073301            0.086323    
%           2.7248              0.080689            0.074796    
%           2.7248              0.080689            0.074796    
%           2.6342              0.067069            0.077335    
%           2.5514              0.067417            0.063124    
%           2.5514              0.067417            0.063124    


% [coeffs, sig_approx, error] = approx_pulse(gen_pulse_train(70,10,4), 20, 1/150);
% 
% approximate signal = 0.066667 + -0.132341 cos(2*pi*1*f0*k) + 0.129393 cos(2*pi*2*f0*k) + -0.124568 cos(2*pi*3*f0*k) + 0.117998 cos(2*pi*4*f0*k) + -0.109862 cos(2*pi*5*f0*k) + 0.100379 cos(2*pi*6*f0*k) + -0.089799 cos(2*pi*7*f0*k) + 0.078400 cos(2*pi*8*f0*k) + -0.066475 cos(2*pi*9*f0*k) + 0.054324 cos(2*pi*10*f0*k) + -0.042246 cos(2*pi*11*f0*k) + 0.030524 cos(2*pi*12*f0*k) + -0.019424 cos(2*pi*13*f0*k) + 0.009182 cos(2*pi*14*f0*k) + 0.000000 cos(2*pi*15*f0*k) + -0.007961 cos(2*pi*16*f0*k) + 0.014582 cos(2*pi*17*f0*k) + -0.019794 cos(2*pi*18*f0*k) + 0.023572 cos(2*pi*19*f0*k) + -0.025935 cos(2*pi*20*f0*k)
% 
% The approximation error is 3.584134