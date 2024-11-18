rng('default');
map1=mapClutter;
map2 = mapMaze;

%% Astar
planner=plannerAStarGrid(map2);
start=[240 10];
goal=[10 140];
way_point=plan(planner,start,goal);
figure(1)
show(planner)
figure(2)
show(map2)
