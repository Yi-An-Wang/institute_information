clear all
close all
clc
Area_X=750;
Area_Y=750;
steps=600; % 1 step = 0.1 second
figure('Position',[10 10 1200 1000])
axis([-(Area_X+1) (Area_X+1) -(Area_Y+1) (Area_Y+1)])
grid on

dis_t=linspace(0,60,601);
rel_d=zeros(1,steps+1);

%frames=cell(steps,1);

robot1=rectangular_GBM([135; 0; 0],100,50,50,[0.4 0.2 0.6],[50; pi/40; 50; -pi/40]);
robot2=rectangular_GBM([-700; -700; pi/8],100,50,50,[0.1 0.5 0.7],[25; pi/8; 25; pi/8]);
rel_d(1)=(robot1.center_position'*robot1.center_position+robot2.center_position'*robot2.center_position)^0.5;
for ii=1:steps
    robot1=robot1.actuate([robot1.v_f; robot1.theta_f; robot1.v_r; robot1.theta_r]);
    robot2=robot2.actuate([robot2.v_f; robot2.theta_f; robot2.v_r; robot2.theta_r]);
    new_pos1=robot1.update_position(0.1);
    new_pos2=robot2.update_position(0.1);
    robot1=robot1.move_GBM(new_pos1,[robot1.theta_f; robot1.theta_r]);
    robot2=robot2.move_GBM(new_pos2,[robot2.theta_f; robot2.theta_r]);
    rel_d(ii+1)=(robot1.center_position'*robot1.center_position+robot2.center_position'*robot2.center_position)^0.5;
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
    %frames{ii}=getframe(gcf);
end

%% result

figure(2)
plot(dis_t,rel_d)
hold on
dot_t=zeros(1,61);
dot_d=zeros(1,61);
dot_t(1)=dis_t(1);
dot_d(1)=rel_d(1);
for ii=1:60
    dot_t(ii+1)=dis_t(ii*10+1);
    dot_d(ii+1)=rel_d(ii*10+1);
end
scatter(dot_t,dot_d,'red')
xlabel("t (sec)")
ylabel("distance (cm)")
title("distance robot(long,width)=(100,50)")

% video=VideoWriter('move_GBM_with_initial_velocity.avi');
% open(video)
% for ii=1:steps
%     writeVideo(video,frames{ii})
% end
% close(video)