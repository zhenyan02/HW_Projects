clc
clear all
close all
%% Read in the training dat
fileID        = fopen('homework_classify_train_2D.dat','r');
[E,countE]    = fscanf(fileID, '%f');
D             = E(3:3:end);                                   % Covert the 2 and 1 catergroy into 1 and -1;
C             = E(2:3:end);
B             = E(1:3:end);
pt_Trainging  =[B,C,D];
fclose(fileID);

%% Read in the test dat
fileID        = fopen('homework_classify_test_2D.dat','r');
[L,countL]    = fscanf(fileID, '%f');
J             = L(3:3:end);
H             = L(2:3:end);
G             = L(1:3:end);
pt_Test       = [G,H,J];
fclose(fileID);
%% Initals
countE        = countE/3;                                            % Total training points
countL        = countL/3;                                            % Total test points
delete '2D.ps'

%%%%%%%%%%%%%%%%% ui for group1 %%%%%%%%%%%%%%%%%%%%%%%%%%%
pts1          = pt_Trainging(pt_Trainging(:,3) == 1,:);
U1x           = mean(pts1(:,1));
U1y           = mean(pts1(:,2));
W1            = [2*U1x, 2*U1y]
W10           = -W1*W1'/4
%%%%%%%%%%%%%%%%% ui for group1 %%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%% ui for group2 %%%%%%%%%%%%%%%%%%%%%%%%%%%
pts2          = pt_Trainging(pt_Trainging(:,3) == 2,:);
U2x           = mean(pts2(:,1));
U2y           = mean(pts2(:,2));
W2            = [2*U2x, 2*U2y]
W20           = -W2*W2'/4
%%%%%%%%%%%%%%%%% ui for group2 %%%%%%%%%%%%%%%%%%%%%%%%%%%

gi            = zeros(countL, 3);                                    % gi(x) matrix


%% test point loop
for i         = 1:countL
    
    %%plot training points
    CV1       = '+rxbsc^m*k';                                        % Color Vector for point
    clf;
    figure(1);
    hold on;
    for m     = 1:2
        PT    = pt_Trainging(pt_Trainging(:,3) == m,:);              % Group the points by gpNum   
        plot(PT(:,1),PT(:,2),CV1(2*m-1:2*m));                        % Plot points with determined color and shape
    end
    %grid on;
    axis([0 25 0 30])
	title({'Test points=',i;})
	xlabel('x-axis');
	ylabel('y-axis');
    
    %% classify points with plug in rules g(x) = wi'*x + wi0
    gi(i,1)   = W1*[pt_Test(i,1),pt_Test(i,2)]' + W10;
    gi(i,2)   = W2*[pt_Test(i,1),pt_Test(i,2)]' + W20;
    % determine which group it belongs to
    if gi(i,1)> gi(i,2)
       gi(i,3)= 1;
       plot(pt_Test(i,1),pt_Test(i,2),'or','linewidth',6);          % Plot points with determined color and shape
       text(3,22,"g1(x) > g2(x) it is red group",'color','red','FontSize',12);   
    else
       gi(i,3)= 2; 
       plot(pt_Test(i,1),pt_Test(i,2),'ob','linewidth',6);          % Plot points with determined color and shape
       text(3,22,"g1(x) < g2(x) it is blue group",'color','blue','FontSize',12);
    end
    
    text(3,28,"g1(x) =W1*x + W10");
    text(3,27,"= [" + W1(1) + "," + W1(2) + "]T x [" + pt_Test(i,1) + "," + pt_Test(i,2)+ "]" + W10 + "=" + gi(i,1));
    text(3,25,"g2(x) =W2*x + W20");
    text(3,24,"= [" + W2(1) + "," + W2(2) + "]T x [" + pt_Test(i,1) + "," + pt_Test(i,2)+ "]" + W20 + "=" + gi(i,2));
	pause(1);
    hold off;
    print('-dpsc2','2D','-append');
end    

