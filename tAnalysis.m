%EK301, Section A2 - Barbone, Group Serendiptity: Iyana, Samarah, Paulette
%3/3/2020
%Script: Paulette Ford

clearvars

%define parameters for truss design
t = inputdlg({'num_of_joints','num_of_members','support_rx_in_X',...
    '1st_rxn_in_Y','2nd_rxn_in_Y','X_joint_pos_vec','Y_joint_pos_vec','load_in_x_dir',...
    'load_in_y_dir'},'Truss Parameters', [1 5; 1 5; 1 30; 1 30;1 30;1 30;1 30;1 30;1 30]); 
          
r = str2num(t{1});
c = str2num(t{2});

Sx = zeros(r,3);
x1 = str2num(t{3});
Sx(x1,:) = 1;

Sy = zeros(r,3);
y1 = str2num(t{4});
y2 = str2num(t{5});
Sy(y1,2) = 1;
Sy(y2,3) = 1;
S = [Sx;Sy];

X = str2num(t{6});
Y = str2num(t{7});

xLoad = str2num(t{8});
yLoad = str2num(t{9});
L = [X';Y'];

[C,Cj,Cm] = connectMat(r,c);
[A,T] = eqMat(X,Y,C,L);

printResults(L,T,Sx,Sy1,Sy2,r,A);
save tAnalysis.mat

%construct connection matrix C
function [C,Cj,Cm] = connectMat(r,c)

C = zeros(r,c);

    for i = 1:r
        m = input(sprintf('Enter member numbers that connect to joint %d: ',i),'s');
        m = str2num(m);
        C(i,m) = 1;
        
        %number of members attached to each joint
        Cj = sum(C,1);
        %Forces acting on each joint
        Cm = sum(C,2);
    end
end

%contruct equation matrix
function [A,T] = eqMat(X,Y,C,L)
[j,m] = size(C);

A = zeros(2*j,m);
n = j;

    for i = 1:j
        n = n+1;
        for k = 1:j
            A(i,k) = X(:,k) - X(:,i);
            A(n,k) = Y(:,k) - Y(:,i);
        end
    end
  T = inv(A)*L
end

%function to print results
function printResults()
%get applied load values
appliedLoad = L((L > 0));


%find total length of members
l = sum(abs(A),2);

%calculate costs
cost = 10 * J + (1/cm)*l
SR
fprintf('Load: %d N\n',appliedLoad);
fprintf('Member forces in Newtons\n');

for i = 1:length(T)-3
    if T(i)< 0
    fprintf ('m%d: %d (C)\n',i,T(i));
    else 
    fprintf('m%d: %d (T)\n',i,T(i));
    end
end
fprintf('Sx1: %d\n Sy1: %d\n Sy2: %d',T(length(T)-3),T(length(T)-2),T(length(T)-3))
fprintf('Cost of Truss: %d\n',cost)
fprintf('Theoretical max load cost ration in N/$: %d',SR);
end


        