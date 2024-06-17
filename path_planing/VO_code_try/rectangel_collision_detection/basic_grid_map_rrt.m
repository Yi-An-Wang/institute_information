map=binaryOccupancyMap(10,10,10);
%obsticals=[1.2 5.0; 2.3 4.0; 3.4 3.0; 4.5 2.0; 5.6 1.0];
w_length1=(1.5:0.05:8.5)';
w_length2=(3:0.05:6)';
w_length3=(4:0.05:8)';
w_length4=(2:0.05:9)';
wall_1=[3*ones(size(w_length1,1),1) w_length1];
wall_2=[w_length2 4*ones(size(w_length2,1),1)];
wall_3=[w_length3 8*ones(size(w_length3,1),1)];
wall_4=[8*ones(size(w_length4,1),1) w_length4];
obsticals=[wall_1; wall_2; wall_3; wall_4];
setOccupancy(map,obsticals,ones(size(obsticals,1),1))
inflate(map, 0.3);

%% RRT
ss=stateSpaceSE2;
sv=validatorOccupancyMap(ss);
sv.Map=map;
sv.ValidationDistance=0.01;
ss.StateBounds=[map.XWorldLimits;map.YWorldLimits;[-pi pi]];
planner=plannerRRT(ss,sv,MaxConnectionDistance=1.0);
start=[0.5 0.5 0];
goal=[9.9 9.9 0];
rng(100,"twister");
[pthObj,solnInfo]=plan(planner,start,goal);

ob_row_col=world2grid(map,obsticals); % get rows and column number of obstacals
figure(1)
show(map)
hold on
% Tree expansion
plot(solnInfo.TreeData(:,1),solnInfo.TreeData(:,2),'.-')
% Draw path
plot(pthObj.States(:,1),pthObj.States(:,2),'r-','LineWidth',2)
hold off

%% Astar

