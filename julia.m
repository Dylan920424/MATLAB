function [EscTime,EscVal, Image] = julia(c, limits, nx, ny, maxEscTime)
%Function that iterates (using vectorization) through a provided space
%nx*ny to calculate each corresponding point's escape time and escape value
%with the given julia function z = z^2 +c

% INPUT Arguments:
% c: a scalar representing the value of the parameter 
% limits: a 4-element vector specifying a rectangular region in the complex plane. Default is[-R R -R R]
% nx: The number of points in the𝑥-direction. Default is 1024
% ny: The number of points in the𝑦-direction. Default is 1024
% maxEscTime: The maximum number of iterations in the sequence allowed. Default is 1000

% OUTPUT Arguments:
% EscTime: a matrix containing all the escape times
% EscVal: a matrix containing all the escape values
% Image: a image produced through the function showJulia

R = (1+sqrt(1+4*abs(c)))/2;
if ~exist('nx','var')||isempty(nx)
    nx = 1024;
end
if ~exist('ny','var')||isempty(ny)
    ny = 1024;
end
if ~exist('maxEscTime','var')||isempty(maxEscTime)
    maxEscTime = 1000;
end
if ~exist('limits','var')||isempty(limits)
    limits = [-R R -R R];
end
x = linspace(limits(1),limits(2),nx);
y = linspace(limits(4),limits(3),ny);
[X,Y] = meshgrid(x,y);
Z = X + 1i*Y;
EscTime = Inf(ny,nx);
EscVal = NaN(ny,nx);
done = false(ny,nx);
for k = 1:maxEscTime
    Z = (Z.^2)+c;
    new = abs(Z) > R & done == 0;
    EscTime(new) = k;
    EscVal(new) = abs(Z(new));
    done(new) = 1;
    if done
        break
    end
end
Image = showJulia(EscTime,EscVal,limits);
end
% Homework Program 4
%
% Name: Wu, Dylan
% Section: 24
% Date: 10/14/2021


