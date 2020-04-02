clearvars

%define truss parameters, joint locations, member joint
%connections, reaction forces and locations, load magnitude%%
C = trussParameters;
[Sx,Sy] = sMat(C);
[X,Y] = jLocate(C);
L = loadVec(C);
[A,T] = eqMat(C,X,Y,Sx,Sy);


save trussScript.mat

%function todefine the number of joints/rows and
%the number of members/columns
  
function C = trussParameters
    r = input('Enter the number of joints: ');
    c = input('Enter the number of members: ');
   
    %define the size of connection matrix C
    C = zeros(r,c);
    
    %insert ones where there are joint/row to member/col connections
for j = 1:r
    for i = 1:c
    C(j,i) = input(sprintf('Enter 1 if joint %d connects to member %d, 0 if not',j,i));
    end
end
end

%define parameters for support matrices
function [Sx,Sy] = sMat(C)
[j,~] = size(C);

Sx = zeros(j,3);
Sy = zeros(j,3);

rXx = input('Enter the joint numbers that have a support reaction in the x direction: ');
Sx(rXx,1) = 1;
rXy = input('Enter the joint numbers that have a support reaction in the y direction: ');
Sy(rXy(1),2) = 1;
Sy(rXy(2),3) = 1;
end

%function creates position vectors in x and y directions
function [X,Y] = jLocate(C)
[j,~] = size(C);

X = zeros(1,j);
Y = zeros(1,j);


for i = 1:j
    X(i) = input(sprintf('Enter the x coordinate of joint %d: ',i));
    Y(i) = input(sprintf('Enter the y coordinate of joint %d: ',i)); 
end
end

%function to define load vector
function L = loadVec(C)
[j,m] = size(C);
L = zeros(2*j,1);

for i = 1:j
     L(i) = input(sprintf('Enter the load in the x direction at joint %d: ',i));
     k = j+i:length(L);
     L(k) = input(sprintf('Enter the load in the y direction at joint %d: ',i));
end
end

%construct equation matrix
function [A,T] = eqMat()
[j,m] = size(C);

C = trussParameters;
[j,m] = size(C);

