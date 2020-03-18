clc
clear all
close all
%% Read in the training dat
fileID          = fopen('homework_classify_train_2D.dat','r');
[E,countE]      = fscanf(fileID, '%f');
D               = E(3:3:end);
C               = E(2:3:end);
B               = E(1:3:end);
pt_Trainging    = [B,C,D];
fclose(fileID);

%% Read in the test dat
fileID          = fopen('homework_classify_test_2D.dat','r');
[L,countL]      = fscanf(fileID, '%f');
J               = L(3:3:end);
H               = L(2:3:end);
G               = L(1:3:end);
pt_Test         = [G,H,J];
fclose(fileID);
%% Initals
countE       = countE/3;                                            % Total training points
countL       = countL/3;                                            % Total test points
delete '2D.ps'

%%%%%%%%%%%%%%%%% K value %%%%%%%%%%%%%%%%%%%%%%%%%%%
for k = 1:2:5
K            = k;                                                   % K value 1,3,5
%%%%%%%%%%%%%%%%% K value %%%%%%%%%%%%%%%%%%%%%%%%%%%

disGrp       = zeros(countL,countE);                                % distance
minKs        = zeros(countL,K);                                     % k min points distance
minPo        = zeros(countL,K);                                     % k min points position
PCate        = ones(countL,1);                                      % test point catergory

%% test point loops
for i = 1:countL
    %% Plot the basic graph
            CV1                     = '+rxbsc^m*k';                             % Color Vector for point
            clf;
            figure(1);
            hold on;
    for m = 1:2
            PT                      = pt_Trainging(pt_Trainging(:,3) == m,:);   % Group the points by gpNum   
            plot(PT(:,1),PT(:,2),CV1(2*m-1:2*m));                               % Plot points with determined color and shape
    end
    
    %% traing point loops 
    for j = 1:countE
            % calculate the distance for each points
            X                       = (pt_Trainging(j,1) - pt_Test(i,1))^2;
            Y                       = (pt_Trainging(j,2) - pt_Test(i,2))^2;
        	disGrp(i,j)             = sqrt(X + Y);
    end
    
    %% find the K minimum distance to target test point and its postion
            [minKs(i,:),minPo(i,:)] = mink(disGrp(i,:),K);  
            
    %% calculate the total catergroy
            total                   = sum(pt_Trainging(minPo(i,:),3));
    if      total > K/2*3
            PCate(i)                = 2;
            plot(pt_Test(i,1),pt_Test(i,2),'ob');                               % Plot points with determined color and shape
    else
            PCate(i)                = 1;
            plot(pt_Test(i,1),pt_Test(i,2),'or');                               % Plot points with determined color and shape
    end

    %% plot the circle for each test point
            th = 0:pi/50:2*pi;
            xunit = minKs(i,K) * cos(th) + pt_Test(i,1);
            yunit = minKs(i,K) * sin(th) + pt_Test(i,2);
            h = plot(xunit, yunit,'green');                                     % Plot the circle for each test point
            grid on;
            title({'K=';K;'Test points=';i;})
            xlabel('x-axis');
            ylabel('y-axis');
            pause(1);
            hold off;
            print('-dpsc2','2D','-append');
end
end
