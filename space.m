function [cs,ns,coords_cs, coords_ns] = space(A,b)
% takes in a matrix A and vector b, finds the column and null space, and
% finds whether or not the vector b is in the column and null space, if it
% is finds and returns the coordinates of the corresponding vector

% Homework Program 8
%
% Name: Wu, Dylan
% Section: 21
% Date: 11/12/2021

% row reduce the matrix A save results to B and piv
[B, piv] = rref(A);

% set the column space to the combination of all the pivot columns found by
% indexing the row reduced matrix A with the piv indexes
cs = A(:, piv);

% find the columns with free variables using the setdiff function
freecols = setdiff(1:size(A,2),piv);
% set the ns matrix to the negative of all the free variable columns
ns = -B(:, freecols);
% if there is no pivots there is not free variables
if(isempty(piv))
    ns = [];
end

% using a for loop to add adjust the ns matrix to include the free
% variables
for i = 1:length(freecols)
    % creates a temp column with the free variable
    tempcol = zeros(1,length(freecols));
    tempcol(i) = 1;
    free = freecols(i);
    % adds it to the appropriate row
    if(size(ns,1)+1 > size(A,2))
        ns(end,:)=tempcol;
    else
        ns = [ns(1:free-1,:);tempcol;ns(free:end,:)];
    end
end

% prints out the result (dimensions)
fprintf("The column space is a %i dimensional subspace of R^%i\n", size(cs,2), size(cs,1))
fprintf("The null space is a %i dimensional subspace of R^%i\n", size(ns,2), size(ns,1))


% check with the dimension size whether or not vector b is a candidate for
% column and null space
if(length(b)~=size(cs,1)&&length(b)~=size(ns,1))
    fprintf("The vector b is not a candidate for either subspace\n")
end

% initialize the coords results to an empty matrix
coords_cs = [];
coords_ns = [];

% if the dimensions of the vector b allows it to be a candidate of the
% column space try to find coords_cs
if(length(b)==size(cs,1))
    % row reduce the augmented matrix of the column space and vector b
    [sol, pivt] = rref([cs b]);
    % if the row reduction is consistent, set coords equal to the results
    if(~isempty(pivt)&&pivt(end)<=size(cs,2))
        coords_cs = sol(1:size(cs,2),end);
        % display the results
        fprintf("b is in R^%i and is in the column space of A, and its coordinates are:\n", length(b))
        disp(coords_cs)
    else
    % if not display the message
        fprintf("The vector b is in R^%i but is not in the column space\n", length(b))
    end
end

% same thing as the column space but for the null space
if(length(b)==size(ns,1))
    [sol, pivt] = rref([ns b]);
    % if the solution is a zero matrix, any vector with the correct
    % dimension is in the null space
    if(~isempty(pivt)&&pivt(end)<=size(ns,2))
        coords_ns = sol(1:size(ns,2),end);
        fprintf("b is in R^%i and is in the null space of A, and its coordinates are:\n", length(b))
        disp(coords_ns)
    else
        fprintf("The vector b is in R^%i but is not in the null space\n", length(b))
    end
end


% 1. A = [1 2 -4 -3 0;-2 -3 5 8 8;2 2 -2 -9 -13]; b = [1;8;2];
% 
% The column space is a 3 dimensional subspace of R^3
% The null space is a 2 dimensional subspace of R^5
% b is in R^3 and is in the column space of A, and its coordinates are:
%    121
%    -30
%     20
% 
% 
% cs =
% 
%      1     2    -3
%     -2    -3     8
%      2     2    -9
% 
% 
% ns =
% 
%     -2    -5
%      3    -2
%      1     0
%      0    -3
%      0     1
% 
% 
% coord_cs =
% 
%    121
%    -30
%     20
% 
% 
% coord_ns =
% 
%      []
     
% 2. A = [1 2 -4 -3 0;-2 -3 5 8 8;2 2 -2 -9 -13]; b = [1;8;2;3];

% The column space is a 3 dimensional subspace of R^3
% The null space is a 2 dimensional subspace of R^5
% The vector b is not a candidate for either subspace
% 
% cs =
% 
%      1     2    -3
%     -2    -3     8
%      2     2    -9
% 
% 
% ns =
% 
%     -2    -5
%      3    -2
%      1     0
%      0    -3
%      0     1
% 
% 
% coord_cs =
% 
%      []
% 
% 
% coord_ns =
% 
%      []
     
% 3. A = [1 2 -4 -3 0;-2 -3 5 8 8;2 2 -2 -9 -13]; b = [1;8;2;3;-1];
% 
% The column space is a 3 dimensional subspace of R^3
% The null space is a 2 dimensional subspace of R^5
% b is in R^5 and is in the null space of A, and its coordinates are:
%      2
%     -1
% 
% 
% cs =
% 
%      1     2    -3
%     -2    -3     8
%      2     2    -9
% 
% 
% ns =
% 
%     -2    -5
%      3    -2
%      1     0
%      0    -3
%      0     1
% 
% 
% coord_cs =
% 
%      []
% 
% 
% coord_ns =
% 
%      2
%     -1
    
% 4. A = [1 2 -4 -3 0;-2 -3 5 8 8;2 2 -2 -9 -13]; b = [1;8;2;3;-2];
% 
% The column space is a 3 dimensional subspace of R^3
% The null space is a 2 dimensional subspace of R^5
% The vector b is in R^5 but is not in the null space
% 
% cs =
% 
%      1     2    -3
%     -2    -3     8
%      2     2    -9
% 
% 
% ns =
% 
%     -2    -5
%      3    -2
%      1     0
%      0    -3
%      0     1
% 
% 
% coord_cs =
% 
%      []
% 
% 
% coord_ns =
% 
%      []
     
% 5. A = [1 0 2;0 1 3;0 0 0]; b = [1;2;3];
% 
% The column space is a 2 dimensional subspace of R^3
% The null space is a 1 dimensional subspace of R^3
% The vector b is in R^3 but is not in the column space
% The vector b is in R^3 but is not in the null space
% 
% cs =
% 
%      1     0
%      0     1
%      0     0
% 
% 
% ns =
% 
%     -2
%     -3
%      1
% 
% 
% coord_cs =
% 
%      []
% 
% 
% coord_ns =
% 
%      []

% 6. A = [2 -2;2 -2];b = [1;1];
% 
% The column space is a 1 dimensional subspace of R^2
% The null space is a 1 dimensional subspace of R^2
% b is in R^2 and is in the column space of A, and its coordinates are:
%     0.5000
% 
% b is in R^2 and is in the null space of A, and its coordinates are:
%      1
% 
% 
% cs =
% 
%      2
%      2
% 
% 
% ns =
% 
%      1
%      1
% 
% 
% coord_cs =
% 
%     0.5000
% 
% 
% coord_ns =
% 
%      1
     
% 7. A = zeros(3);b = zeros(3,1);
% 
% The column space is a 0 dimensional subspace of R^3
% The null space is a 3 dimensional subspace of R^3
% The vector b is in R^3 but is not in the column space
% b is in R^3 and is in the null space of A, and its coordinates are:
%      0
%      0
%      0
% 
% 
% cs =
% 
%   3×0 empty double matrix
% 
% 
% ns =
% 
%      1     0     0
%      0     1     0
%      0     0     1
% 
% 
% coord_cs =
% 
%      []
% 
% 
% coord_ns =
% 
%      0
%      0
%      0

     
% 8. A = eye(3);b = zeros(3,1);
% 
% The column space is a 3 dimensional subspace of R^3
% The null space is a 0 dimensional subspace of R^3
% b is in R^3 and is in the column space of A, and its coordinates are:
%      0
%      0
%      0
% 
% The vector b is in R^3 but is not in the null space
% 
% cs =
% 
%      1     0     0
%      0     1     0
%      0     0     1
% 
% 
% ns =
% 
%   3×0 empty double matrix
% 
% 
% coord_cs =
% 
%      0
%      0
%      0
% 
% 
% coord_ns =
% 
%      []
     
% 9. A = [1 0 0 1;0 1 0 2;0 0 1 3;0 0 -1/3 -1]; b = [1;2;3;-1];
% 
% The column space is a 3 dimensional subspace of R^4
% The null space is a 1 dimensional subspace of R^4
% b is in R^4 and is in the column space of A, and its coordinates are:
%      1
%      2
%      3
% 
% b is in R^4 and is in the null space of A, and its coordinates are:
%     -1
% 
% 
% cs =
% 
%     1.0000         0         0
%          0    1.0000         0
%          0         0    1.0000
%          0         0   -0.3333
% 
% 
% ns =
% 
%     -1
%     -2
%     -3
%      1
% 
% 
% coord_cs =
% 
%      1
%      2
%      3
% 
% 
% coord_ns =
% 
%     -1

end
