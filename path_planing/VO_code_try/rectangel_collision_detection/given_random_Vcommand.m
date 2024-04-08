clear all
close all
clc
Area_X=750;
Area_Y=750;
steps=400;
figure('Position',[10 10 1200 1000])
axis([-(Area_X+1) (Area_X+1) -(Area_Y+1) (Area_Y+1)])
grid on
v1_cmd=zeros(3,steps);
v2_cmd=zeros(3,steps);

actuate_cmd1=zeros(4,steps);
actuate_cmd2=zeros(4,steps);
v_vector1=zeros(4,steps);
v_vector2=zeros(4,steps);

for ii=2:steps
    v1_cmd(1,ii)=v1_cmd(1,ii-1)+randn;
    v2_cmd(1,ii)=v2_cmd(1,ii-1)+randn;
    v1_cmd(2,ii)=v1_cmd(2,ii-1)+randn;
    v2_cmd(2,ii)=v2_cmd(2,ii-1)+randn;
    v1_cmd(3,ii)=v1_cmd(3,ii-1)+randn*0.01;
    v2_cmd(3,ii)=v2_cmd(3,ii-1)+randn*0.01;
end
robot1=rectangular_GBM([50; 50; 0],100,50,58,[0.1 0.6 0.3]);
robot2=rectangular_GBM([-50; -50; 0],100,50,58,[0.4 0.3 0.7]);
for ii=1:steps
    [actuate_cmd1(:,ii),v_vector1(:,ii)]=robot1.inverse_kinematics(v1_cmd(:,ii));
    [actuate_cmd2(:,ii),v_vector2(:,ii)]=robot2.inverse_kinematics(v2_cmd(:,ii));
    robot1=robot1.actuate(actuate_cmd1(:,ii),v_vector1(:,ii));
    robot2=robot2.actuate(actuate_cmd2(:,ii),v_vector2(:,ii));
    new_pos1=robot1.update_position(0.1);
    new_pos2=robot2.update_position(0.1);
    robot1=robot1.move_GBM(new_pos1,[robot1.theta_f; robot1.theta_r]);
    robot2=robot2.move_GBM(new_pos2,[robot2.theta_f; robot2.theta_r]);
    robot1.collision_bool=detect_collision(robot1,robot2);
    robot2.collision_bool=robot1.collision_bool;
    robot1.draw_collision_pos
    robot2.draw_collision_pos
    pause(0.01)
    if rem(ii,20)==0
        hold on
        scatter(robot1.center_position(1),robot1.center_position(2),'g.')
        scatter(robot2.center_position(1),robot2.center_position(2),'b.')
        hold off
    end
end