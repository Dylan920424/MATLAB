function [M] = mult(M,d,row)
% multiplies the input row of matrix M with the nonzero variable of d

% Checking and setting the base cases for input row
if ~exist('row','var')
    row = 1;
end
if d==0
    error("d may not be 0")
end
if row < 1 || row > size(M,1) || row ~= round(row)
    error("row is out of bounds")
end

% tell users which row is being multipled by how much
fprintf("row %i is being multipled by %f\n", row, d)

% multiply row of M by d
M(row,:) = M(row,:)*d
end

