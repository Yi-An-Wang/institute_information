clear all
close all
clc
Area_X=750;
Area_Y=750;
steps=600;
figure('Position',[10 10 1200 1000])
axis([-(Area_X+1) (Area_X+1) -(Area_Y+1) (Area_Y+1)])
grid on

frames=cell(steps,1);

robot1=rectangular_GBM([135; 0; 0],100,50,50,[0.4 0.2 0.6],[50; pi/40; 50; -pi/40]);
robot2=rectangular_GBM([-700; -700; pi/8],100,50,50,[0.1 0.5 0.7],[25; pi/8; 25; pi/8]);
for ii=1:steps
    robot1=robot1.actuate([robot1.v_f; robot1.theta_f; robot1.v_r; robot1.theta_r]);
    robot2=robot2.actuate([robot2.v_f; robot2.theta_f; robot2.v_r; robot2.theta_r]);
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
        scatter(robot1.center_position(1),robot1.center_position(2),'m.')
        scatter(robot2.center_position(1),robot2.center_position(2),'c.')
        hold off
    end
    frames{ii}=getframe(gcf);
end

video=VideoWriter('move_GBM_with_initial_velocity.avi');
open(video)
for ii=1:steps
    writeVideo(video,frames{ii})
end
close(video)