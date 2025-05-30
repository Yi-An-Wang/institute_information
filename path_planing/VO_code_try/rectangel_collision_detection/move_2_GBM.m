Area_X=100;
Area_Y=100;
steps=200;
origin_1=[30;0];
origin_2=[-30;0];
path_1=[origin_1(1)+50*cos(linspace(0,2*pi,steps));origin_1(2)+50*sin(linspace(0,2*pi,steps))];
orientation_1=pi/2*ones(1,steps)+linspace(0,2*pi,steps);
path_2=[origin_2(1)-50*cos(linspace(0,2*pi,steps));origin_2(2)+50*sin(linspace(0,2*pi,steps))];
orientation_2=pi/2*ones(1,steps)-linspace(0,2*pi,steps);
figure(1)
axis([-(Area_X+1) (Area_X+1) -(Area_Y+1) (Area_Y+1)])
grid on
hold on
plot(path_1(1,:),path_1(2,:),'blue',path_2(1,:),path_2(2,:),'green')
hold off
robot1=rectangular_GBM([origin_1(1)+50; origin_1(2); pi/2],16,10,12,[0.0 0.9 0.3]);
robot2=rectangular_GBM([origin_2(1)-50; origin_2(2); pi/2],16,10,12,[0.3 0.4 0.2]);
for ii=1:steps
    robot1=robot1.move_GBM([path_1(:,ii); orientation_1(ii)],[pi/8; -pi/8]);
    robot2=robot2.move_GBM([path_2(:,ii); orientation_2(ii)],[-pi/8; pi/8]);
    robot1.collision_bool=detect_collision(robot1,robot2);
    robot2.collision_bool=robot1.collision_bool;
    robot1.draw_collision_pos
    robot2.draw_collision_pos
    pause(0.05)
end