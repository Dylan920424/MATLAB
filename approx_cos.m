function [coeffs,sig_approx,error] = approx_pulse(sig,n,f0)

x = [];
for i= 0:n
    x(:,end+1) = cos(2*pi*i*f0*(1:1/f0));
end

coeffs = (x'*x)\(x'*sig');

sig_approx_array

for i = 0:n
    
    sig_approx_array(:,end+1) = coeffs(i+1)*cos(2*pi*i*f0*@k);
    
end

end