rng('default');
map1=mapClutter;

%% Astar
planner=plannerAStarGrid(map1);
start=[50 240];
goal=[240 50];
way_point=plan(planner,start,goal);
figure('Position',[10 10 1200 1000])
show(planner)
