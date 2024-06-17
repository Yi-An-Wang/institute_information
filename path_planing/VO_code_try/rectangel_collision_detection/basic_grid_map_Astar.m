map_length=1000;
map_width=1000;
plan_map=binaryOccupancyMap(map_width,map_length,1);
w_length1=(50:900)'; % virtical start from 80
w_length2=(80:650)'; % horizontal start from 880
w_length3=(110:950)'; % virtical start from 850
w_length4=(220:850)'; % horizontal start form 160
wall_1=[80*ones(size(w_length1,1),1) w_length1];
wall_2=[w_length2 880*ones(size(w_length2,1),1)];
wall_3=[850*ones(size(w_length3,1),1) w_length3];
wall_4=[w_length4 160*ones(size(w_length4,1),1)];
obsticals=[wall_1; wall_2; wall_3; wall_4];
setOccupancy(plan_map,obsticals,ones(size(obsticals,1),1))
inflate(plan_map, 50);

%% Astar
planner=plannerAStarGrid(plan_map);
start=[1000 1];
goal=[1 1000];
ij_point=plan(planner,start,goal);
way_point=[-ij_point(:,1)]

figure(1)
show(planner)

figure(2)
show(plan_map)
hold on
plot(way_point(:,1),way_point(:,2))
hold off