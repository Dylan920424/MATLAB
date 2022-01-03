function [ranks] = PageRankA(A, d)
H = A./max(1,sum(A,1));
I = eye(size(A));
one = ones(size(A,1),1);
r = (I-d*H)\((1-d)*one)
end
