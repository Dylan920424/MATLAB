function [M] = exchange(M,row1, row2)
% A function that exchanges the row1 and row2 of the given matrix M

% Checking and setting the base cases for input row1 and row2
if ~exist('row1','var')
    row1 = 1;
end
if ~exist('row2','var')&&~exist('row1','var')
    row2 = 2;
elseif ~exist('row2','var')
    row2 = 1;
end
if row1 < 1 || row1 > size(M,1) || row2 < 1 || row2 > size(M,1) || row1 ~= round(row1) || row2 ~= round(row2)
    error("inputed rows are not within range")
end

% tell users which two rows are getting switched
fprintf("row %i and row %i are getting switched\n", row1, row2)

% save row1 as a memory and switch row1 with row2
memory_row = M(row1,:);
M(row1,:) = M(row2,:);
M(row2,:) = memory_row
end

