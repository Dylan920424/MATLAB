% Homework Program 5
%
% Name: Wu, Dylan
% Date: 10/21/2021

function [M,piv] = reduce(M)
% finds the reduced echelon form of M and the positions of pivots piv
piv = [];
% for loop that turns M into echelon form 
for ii = 1:size(M,1)
    % looks for the max val and max index of each submatrix for each loop
    [max_val,max_index] = max(abs(M(ii:size(M,1),:)),[],1);
    % corrects it for the submatrix
    max_index = max_index+ii-1;
    % sets the pivot column with the first non-zero value of max_val
    pivot_col = find(max_val,1);
    % check to see if the row ii is all zeros
    if isempty(pivot_col)
        continue
    end
    piv(end+1) = pivot_col;
    % add the pivot_col to the array piv
    % sets pivot row to the index of pivot column in array max_index
    pivot_row = max_index(pivot_col);
    % exchanges the row with the largest value at ii to row ii
    M = exchange(M, pivot_row,ii);
    % for loop that clears all values beneath row ii at column pivot_col
    for jj = ii+1:size(M,1)
        % set the multipler to the value of row jj column pivot_col over
        % ii,pivot_col
        val = -1*(M(jj,pivot_col)/M(ii,pivot_col));
        % skip if val is 0
        if val == 0
            continue
        end
        M = add(M, val,ii, jj);
    end
    % set numbers close to 0 to 0 to prevent computation errors
    M(abs(M)<1e-6)=0;
end

% for loop to turn echelon form into reduced echelon form
for ii = size(M,1):-1:1
    % find the pivot at row ii
    pivot_col = find(M(ii,:),1);
    % check if there is a pivot at ii, if not skip row
    if isempty(pivot_col)
        continue
    end
    % set all pivots to 1 by dividing the row by the pivot value
    value = 1/M(ii,pivot_col);
    M = mult(M,value,ii);
    % for loop that clears all the non-zero values above row ii
    for jj = ii-1:-1:1
       M = add(M, -M(jj,pivot_col)/M(ii,pivot_col),ii, jj);
    end
end
end

function M = exchange(M,row1, row2)
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
M(row2,:) = memory_row;
end

function M = mult(M,d,row)
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
M(row,:) = M(row,:)*d;
end

function M = add(M,r, row1, row2)
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
M(row2,:) = M(row2,:) + M(row1,:)*r;
end

% A = randi([-5 5], 4, 10); [R, piv] = reduce(A)
% row 4 and row 1 are getting switched
% row 1 times -0.800000 is added to row 2
% row 1 times 0.800000 is added to row 3
% row 1 times -0.600000 is added to row 4
% row 2 and row 2 are getting switched
% row 2 times -0.250000 is added to row 3
% row 2 times 0.083333 is added to row 4
% row 4 and row 3 are getting switched
% row 3 times 0.120000 is added to row 4
% row 4 and row 4 are getting switched
% row 4 is being multipled by -12.500000
% row 4 times -7.666667 is added to row 3
% row 4 times -3.200000 is added to row 2
% row 4 times 4.000000 is added to row 1
% row 3 is being multipled by 0.480000
% row 3 times -1.000000 is added to row 2
% row 3 times -5.000000 is added to row 1
% row 2 is being multipled by -0.208333
% row 2 times -1.000000 is added to row 1
% row 1 is being multipled by 0.200000
% 
% R =
% 
%     1.0000         0         0         0 -350.2500 -563.2500  -91.5000   75.2500  -33.0000  -66.5000
%          0    1.0000         0         0    7.2500   14.2500    1.5000   -1.2500    2.0000    1.5000
%          0         0    1.0000         0  287.0000  461.0000   75.0000  -62.0000   27.0000   54.0000
%          0         0         0    1.0000  -78.5000 -125.5000  -20.0000   17.5000   -8.0000  -14.0000
% 
% 
% piv =
% 
%      1     2     3     4
% 
% A = randi([-5 5], 10, 4); [R, piv] = reduce(A)
% 
% row 3 and row 1 are getting switched
% row 1 times 0.333333 is added to row 2
% row 1 times 0.333333 is added to row 3
% row 1 times -1.000000 is added to row 4
% row 1 times 1.000000 is added to row 5
% row 1 times 0.333333 is added to row 7
% row 1 times -0.666667 is added to row 8
% row 1 times -0.666667 is added to row 9
% row 1 times -1.000000 is added to row 10
% row 4 and row 2 are getting switched
% row 2 times -0.222222 is added to row 3
% row 2 times 0.444444 is added to row 4
% row 2 times -0.333333 is added to row 5
% row 2 times 0.944444 is added to row 7
% row 2 times -0.555556 is added to row 8
% row 2 times -0.055556 is added to row 9
% row 2 times -0.833333 is added to row 10
% row 8 and row 3 are getting switched
% row 3 times -0.413043 is added to row 4
% row 3 times 0.652174 is added to row 5
% row 3 times 0.978261 is added to row 6
% row 3 times 0.565217 is added to row 7
% row 3 times 0.500000 is added to row 8
% row 3 times -0.804348 is added to row 9
% row 3 times -0.913043 is added to row 10
% row 5 and row 4 are getting switched
% row 4 times 0.446341 is added to row 5
% row 4 times 0.407317 is added to row 6
% row 4 times 0.965854 is added to row 7
% row 4 times -0.617073 is added to row 8
% row 4 times -0.075610 is added to row 9
% row 4 times -0.395122 is added to row 10
% row 4 is being multipled by 0.112195
% row 4 times 1.666667 is added to row 3
% row 4 times 6.000000 is added to row 2
% row 4 times -3.000000 is added to row 1
% row 3 is being multipled by -0.195652
% row 3 times -2.000000 is added to row 2
% row 3 times -0.000000 is added to row 1
% row 2 is being multipled by -0.166667
% row 2 times -2.000000 is added to row 1
% row 1 is being multipled by 0.333333
% 
% R =
% 
%      1     0     0     0
%      0     1     0     0
%      0     0     1     0
%      0     0     0     1
%      0     0     0     0
%      0     0     0     0
%      0     0     0     0
%      0     0     0     0
%      0     0     0     0
%      0     0     0     0
% 
% 
% piv =
% 
%      1     2     3     4
%      
% A = [1 2 0 0 0;0 0 0 2 3;0 0 2 1 3]; [R, piv] = reduce(A)
% 
% row 1 and row 1 are getting switched
% row 3 and row 2 are getting switched
% row 3 and row 3 are getting switched
% row 3 is being multipled by 0.500000
% row 3 times -1.000000 is added to row 2
% row 3 times -0.000000 is added to row 1
% row 2 is being multipled by 0.500000
% row 2 times -0.000000 is added to row 1
% row 1 is being multipled by 1.000000
% 
% R =
% 
%     1.0000    2.0000         0         0         0
%          0         0    1.0000         0    0.7500
%          0         0         0    1.0000    1.5000
% 
% 
% piv =
% 
%      1     3     4
% 
% a = [1 2 4 3 5]; A = [a;a;a;a]; [R, piv] = reduce(A)
% 
% row 1 and row 1 are getting switched
% row 1 times -1.000000 is added to row 2
% row 1 times -1.000000 is added to row 3
% row 1 times -1.000000 is added to row 4
% row 1 is being multipled by 1.000000
% 
% R =
% 
%      1     2     4     3     5
%      0     0     0     0     0
%      0     0     0     0     0
%      0     0     0     0     0
% 
% 
% piv =
% 
%      1



