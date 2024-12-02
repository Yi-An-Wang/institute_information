rng('default');
map1=mapClutter;
map2 = mapMaze(10,3,'MapSize',[30 30]);

%% Astar
planner=plannerAStarGrid(map2);
start=[140 10];
goal=[10 140];
way_point=plan(planner,start,goal);
figure(1)
show(planner)
figure(2)
show(map2)
