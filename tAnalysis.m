%EK301, Section A2 - Barbone, Group Serendiptity: Iyana, Samarah, Paulette
%3/3/2020
%Script: Paulette Ford

clearvars

%function to prompt user for truss parameters
J = input('Enter the number of joints: ');
M = input('Enter the number of members: ');
XY = input('Enter the XY coordinates of the joints: ');

X = XY(:,1);
Y = XY(:,2);

mL = input('Enter the member lengths: ');
m = 1:M; %vector to number members

%creat support reaction matrix
S = zeros(2*J,3);
Sx = input('Enter the joint location(s) for support reactions in the X direction: ');
Sy = input('Enter the joint location(s) for support reaction(s) is the Y direction: ');

S(Sx,:) = 1;
S(J+Sy(1),1) = 1;
S(J+Sy(2),2) = 1;

%create connection matrix C
C = zeros(J,M);

[r,c] = size(C);

for i = 1:r
    for j = 1:c
        
        if (circshift(X,1,2) - X(i)) == 0  
               C(i,m(j)) = 1;
       
        else
            
            if (circshift(Y,1,2) - Y(i)) == 0
               C(j,m(i)) = 1;
            else
                C(j,m(i)) = 1;
            end
        end
    end
end
    