function [M] = add(M,r, row1, row2)
% adds r times row1 to row2 of given matrix M

% Checking and setting the base cases for input row1 and row2
if ~exist('row2','var')
    row2 = 1;
end
if ~exist('row1','var')
    error("not enough input arguments")
end
if row1 < 1 || row1 > size(M,1) || row2 < 1 || row2 > size(M,1) || row1 ~= round(row1) || row2 ~= round(row2)
    error("inputed rows are not within range")
end

% tell users which row is added by how much of another row
fprintf("row %i times %f is added to row %i\n", row1, r, row2)

% adding row1 times r to row2
M(row2,:) = M(row2,:) + M(row1,:)*r
end

