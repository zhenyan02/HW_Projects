clc
clear all
close all
%% Read in the dat
fileID      = fopen('HW_6_data_2D.dat','r');
[D,count]   = fscanf(fileID, '%f');
C           = D(2:2:end);
B           = D(1:2:end);
A           = [B,C];
fclose(fileID);
%% Initals
count       = count/2;                                              % Total points
%%%%%%%%%%%%%%%%% Cluster Numbers%%%%%%%%%%%%%%%%%%%%%%%%%%%
K           = 2;                                        % Cluster Numbers
%%%%%%%%%%%%%%%%% Cluster Numbers%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%% Tolerence %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tol         = 0.1;                                    % Tolerence
%%%%%%%%%%%%%%%%% Tolerence %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disGrp      = zeros(count, K + 2);                                  % distance and groups 
centPnt     = A(randperm(count,K),:);                               % Random start point
stps        = 0;                                                    % Total moving steps
err         = tol;
delete '2D.ps'
%% K-Means loops
while err >= tol
      err = 0.99999*tol;
    %% Distance and Group loops 
    for i = 1:count
        for j = 1:K                                                % 1:K record all the distance to the centers
        	disGrp(i,j) = norm(A(i,:) - centPnt(j,:));      
        end
        [Dist gpNum]  = min(disGrp(i,1:K));                
        disGrp(i,K+1) = gpNum;                                     % K+1 record the group number
        disGrp(i,K+2) = Dist;                                      % K+2 record the min distance
        %%disp(Distance);

    end

    stps = stps+1;                                                 % total steps
    
    %% Plot and Print into PS format
    CV1    = '+rxbsc^m*k';                                         % Color Vector for point
    CV2    = 'orobocomok';                                         % Color Vector for Center
    clf
    figure(1);
    hold on
    for i = 1:K
        PT = A(disGrp(:,K+1) == i,:);                              % Group the points by gpNum   
        plot(PT(:,1),PT(:,2),CV1(2*i-1:2*i));                      % Plot points with determined color and shape
        plot(centPnt(i,1),centPnt(i,2),CV2(2*i-1:2*i),'LineWidth',10);
                                                                   % Plot cluster centers
    end
    hold off
    grid on
    pause(1)
    title(['2D    Step = ',num2str(stps),'    Tolerence = ',num2str(tol)]);
    xlabel('x-axis');
    ylabel('y-axis');
    str = 'In code Tolerence = max (movement of each cluster in each step)';
    text(25,0,str);
    print('-dpsc2','2D','-append');
    
        %% new center loops 
	for i = 1:K
        gp         = (disGrp(:,K+1) == i);                         % Group the points by gpNum
        err        = max(err,norm(centPnt(i,:)-mean(A(gp,:))));
        centPnt(i,:) = mean(A(gp,:));                              % Calculate the new center
    end
end   
disp(stps);