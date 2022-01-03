function [Vnew] = transform_mesh(A,V,T,C)
% Takes in a mesh with vector V and uses the inputed matrix A to transform
% vector V into a new vector Vnew and plots both graphs on the same axis

% Homework Program 7
%
% Name: Wu, Dylan
% Section: 21
% Date: 11/04/2021

% validating every input to check if it is according to the rules
% check if A matrix is 3x3 and numeric
validateattributes(A, {'numeric'}, {'size',[3,3]},1);
% check if V matrix is numeric with 3 columns and is 2d
validateattributes(V, {'numeric'}, [{'ncols', 3},{'2d'}],2);
% check if T matrix is numeric with 4 columns, is 2d, filled with
% nonnegative integers with numbers that are smaller than the amount of
% rows in the V matrix
validateattributes(T, {'numeric'}, [{'ncols', 4},{'2d'},{'integer'},{'nonnegative'},{'<=', size(V,1)}],3);
% check if the C matrix is numeric with 3 columns, is 2d, nonnegative and
% with all values that are smaller than 1
validateattributes(C, {'numeric'}, [{'ncols', 3},{'2d'},{'nonnegative'},{'<=', 1}],4);

% create a temporary solution matrix with size V
Vnew = zeros(size(V))

% apply the transformation to every vertor row in the matrix V through
% matrix multiplication
Vnew = V*A'

% print out the results of both V and Vnew in the same axis
trisurf(T(:,1:3),Vnew(:,1),Vnew(:,2),Vnew(:,3),T(:,4));
hold on
trisurf(T(:,1:3),V(:,1),V(:,2),V(:,3),T(:,4), ...
'EdgeColor','none','FaceAlpha',0.2);
hold off
colormap(C);
axis equal;

% 1. 
% A_scale = [0.5 0 0; 0 1.5 0; 0 0 1.5];
% 
% A_scale =
% 
%     0.5000         0         0
%          0    1.5000         0
%          0         0    1.5000
         
% 2.
% A_refl = [1 0 0; 0 1 0; 0 0 -1];
% 
% A_refl =
% 
%      1     0     0
%      0     1     0
%      0     0    -1

% 3.
% A_rot = vrrotvec2mat([1 1 0 pi/3]);
% 
% A_rot =
% 
%     0.7500    0.2500    0.6124
%     0.2500    0.7500   -0.6124
%    -0.6124    0.6124    0.5000

% 4.
% A = A_scale*A_refl*A_rot
%
% A =
% 
%     0.3750    0.1250    0.3062
%     0.3750    1.1250   -0.9186
%     0.9186   -0.9186   -0.7500


% 5. 
% B = A_rot*A_scale*A_refl
%
% B =
% 
%     0.3750    0.3750   -0.9186
%     0.1250    1.1250    0.9186
%    -0.3062    0.9186   -0.7500

end

