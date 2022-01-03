function [ranks] = PageRank(H, d)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
I = eye(size(H));
one = ones(size(H,1),1);
ranks = (I-d*H)\((1-d)*one)
end


