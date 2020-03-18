clc
clear all
close all
%% Read in the dat
fileID      = fopen('HW_6_data_1D.dat','r');
[A,count]   = fscanf(fileID, '%f');
fclose(fileID);
%% Initals
%%%%%%%%%%%%%%%%% Cluster Numbers%%%%%%%%%%%%%%%%%%%%%%%%%%%
K           = 2;                                        % Cluster Numbers
%%%%%%%%%%%%%%%%% Cluster Numbers%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%% Tolerence %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tol         = 0.001;                                    % Tolerence
%%%%%%%%%%%%%%%%% Tolerence %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disGrp      = zeros(count, K + 2);                      % distance and groups 
centPnt     = A(randperm(count,K));                     % Random start point
stps        = 0;                                        % Total moving steps
err         = tol;
delete '1D.ps'

%% K-Means loops
while err >= tol
      err = 0.99999*tol;
    %% Distance and Group loops 
    for i = 1:count
        for j = 1:K                                     % 1:K record all the distance to the centers
        	disGrp(i,j) = norm(A(i) - centPnt(j));      
        end
        [Dist gpNum]  = min(disGrp(i,1:K));                
        disGrp(i,K+1) = gpNum;                          % K+1 record the group number
        disGrp(i,K+2) = Dist;                           % K+2 record the min distance
        %%disp(Distance);

    end
    
    stps = stps+1;
    
    %% Plot 
    CV1    = '+rxbsc^m*k';                              % Color Vector for point
    CV2    = 'orobocomok';                              % Color Vector for Center
    clf
    figure(1);
    hold on
    for i = 1:K
        PT = A(disGrp(:,K+1) == i);                     % Group the points by gpNum   
        plot(PT,0,CV1(2*i-1:2*i));                      % Plot points with determined color and shape
        plot(centPnt(i),0,CV2(2*i-1:2*i),'LineWidth',10);% Plot cluster centers
    end
    hold off
    grid on
    pause(1)
    title(['1D    Step = ',num2str(stps),'    Tolerence = ',num2str(tol)]);
    xlabel('x-axis');
    ylabel('y-axis');
    str = 'In code Tolerence = max (movement of each cluster in each step)';
    text(25,-1.3,str);
    print('-dpsc2','1D','-append');
    %plot end
    
    
    %% new center loops 
	for i = 1:K
        gp         = A((disGrp(:,K+1) == i));           % Group the points by gpNum
        err        = max(err,norm(centPnt(i)-mean(gp)));
        centPnt(i) = mean(gp);                          % Calculate the new center
    end
end   
disp(stps);