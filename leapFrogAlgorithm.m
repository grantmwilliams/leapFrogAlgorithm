%% Leap Frog Algorithm
clear;close all;clc;
%% Initialization of Variables
popSize = 20;           % Number of popluation members
xbound = [-3, 3];       % X Bounds
ybound = [-3, 3];       % Y Bounds
genLimit = 150;         % Generation Limit
fit = 1;                % 1 for peaks 2 for goldsteen
plotting = 0;           % 1 for plot 0 for no plotting
confidence = .99;       % Confidence as a percentage
top_percent = .01;      % Percentage we are looking for
ensembles = 1;       % How many times to run algorithm
%ensembles = ceil(log(1-confidence)/log(1-top_percent)); % Calc ensembles to nearest whole number

best_values = zeros(ensembles,1);
x_coords = zeros(ensembles,1);
y_coords = zeros(ensembles,1);
time_to_run = zeros(ensembles,1);


%*************************************************************************%
for i = 1:ensembles
tic
%% Randomly Place Players (Within Bounds of Problem)
xy(:,1) = (xbound(2)-xbound(1)).*rand(popSize,1)+xbound(1);
xy(:,2) = (ybound(2)-ybound(1)).*rand(popSize,1)+ybound(1);
%*************************************************************************%
 
%% Best Fitness of Initial Individuals
% Vectorized Version of Fitness
F =  vecFit(fit,xy);
    
[best, bestIdx] = max(F); bestCoord = xy(bestIdx,:); % Best Value % Coords
%*************************************************************************%
 
%% Main Loop
for gen = 1:genLimit
%*************************************************************************%
 
% Find Lowest Fitness
[worst, worstIdx] = min(F); worstCoord = xy(worstIdx,:); % Worst Value & Coords
%*************************************************************************%
 
% Lowest Fitness Leaps Over Best Fitness (makes sure jump is in bounds)
for j = 1:10
xy(worstIdx,:) = xy(bestIdx,:) - rand(1,2).*(xy(worstIdx,:)-xy(bestIdx,:));    
if (xy(worstIdx,1) > xbound(1) && xy(worstIdx,1) < xbound(2) && xy(worstIdx,2) > ybound(1) && xy(worstIdx,2) < ybound(2))
    break;
end % End If statement for boundary check
end % End loop to look for bounded jump
%*************************************************************************%

% Plot stuff
if (plotting == 1)
figure(1)
contour(X,Y,Z,30); 
hold on;
scatter(xy(:,1),xy(:,2),'filled');
drawnow;
hold off;
end
%*************************************************************************%
 
% Check for New Best
F(worstIdx,1) = fitness(fit,worstIdx,xy);
if (F(worstIdx,1) > best)
    best = F(worstIdx,1);
    bestIdx = worstIdx;
end

%*************************************************************************%
end % Ends Generation Loops

%% Stop - Print Final Stats

best_values(i,1) = best;
x_coords(i,1) = xy(bestIdx,1);
y_coords(i,1) = xy(bestIdx,2);
time_to_run(i,1) = toc;
end

%% Prints a Pretty Table
[best_values,ii] = sort(best_values);
x_coords = x_coords(ii);
y_coords = y_coords(ii);
time_to_run = time_to_run(ii);
disp(table(best_values,x_coords,y_coords,time_to_run));
disp('-----------------------------------------------------------');
fprintf('After: %f runs:    Best Value: %f     Total Time To Run: %f     Mean Time: %f\n',ensembles,max(best_values),sum(time_to_run),mean(time_to_run));

