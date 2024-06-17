clear all
close all
clc
Area_X=750;
Area_Y=750;
steps=1500;
time_step=0.05;
figure('Position',[10 10 1200 1000])
axis([-(Area_X+1) (Area_X+1) -(Area_Y+1) (Area_Y+1)])
grid on
v1_cmd=zeros(3,steps);
v2_cmd=zeros(3,steps);

actuate_cmd1=zeros(4,steps);
actuate_cmd2=zeros(4,steps);
v_vector1=zeros(4,steps);
v_vector2=zeros(4,steps);
modify_xy_cmd1=zeros(4,steps);
modify_xy_cmd2=zeros(4,steps);
modify_act_cmd1=zeros(4,steps);
modify_act_cmd2=zeros(4,steps);
robot1_state=zeros(3,steps);
robot2_state=zeros(3,steps);

%frames=cell(steps,1);

% for ii=2:steps
%     v1_cmd(1,ii)=v1_cmd(1,ii-1)+randn;
%     v2_cmd(1,ii)=v2_cmd(1,ii-1)+randn;
%     v1_cmd(2,ii)=v1_cmd(2,ii-1)+randn;
%     v2_cmd(2,ii)=v2_cmd(2,ii-1)+randn;
%     v1_cmd(3,ii)=v1_cmd(3,ii-1)+randn*5e-3;
%     v2_cmd(3,ii)=v2_cmd(3,ii-1)+randn*5e-3;
% end
v1_cmd(1,:)=50*ones(1,steps);
v1_cmd(2,:)=0.0*ones(1,steps);
v1_cmd(3,:)=pi/20*ones(1,steps);

destination=[700; 300];
hold on
scatter(destination(1),destination(2))
hold off

robot1=rectangular_GBM([75; 75; 0],100,50,58,[0.1 0.6 0.3]);
robot2=rectangular_GBM([-600; -600; 0],100,50,58,[0.4 0.3 0.7]);
% for pid
angular_error=zeros(1,steps);
previous_error=0;
error_diff=zeros(1,steps);
sum_error=zeros(1,steps);
%
for ii=1:steps
    destination_vector=(destination-robot2.center_position);
    best_unit=destination_vector/(dot(destination_vector,destination_vector))^0.5;
    %pid cmd
    if ii==1
        angular_error=robot2.GBM_pos(3)-atan2(destination_vector(2),destination_vector(1));
    elseif robot2.GBM_pos(3)<0
        angular_error(ii)=-mod(-robot2.GBM_pos(3),2*pi)-atan2(robot2.local_motion(2),robot2.local_motion(1));
    else
        angular_error(ii)=mod(robot2.GBM_pos(3),2*pi)-atan2(robot2.local_motion(2),robot2.local_motion(1));
    end
    error_diff(ii)=(angular_error(ii)-previous_error)/time_step;
    previous_error=angular_error(ii);
    if ii==1
        sum_error(ii)=angular_error(ii)*time_step;
    else
        sum_error(ii)=sum_error(ii-1)+angular_error(ii)*time_step;
    end
    kp=-0.5;
    kd=-0;
    ki=-0.00;
    angular_cmd=kp*angular_error(ii)+kd*error_diff(ii)+ki*sum_error(ii);
    %
    v2_cmd(1,ii)=20*best_unit(1);
    v2_cmd(2,ii)=20*best_unit(2);
    v2_cmd(3,ii)=angular_cmd;
    [actuate_cmd1(:,ii),v_vector1(:,ii)]=robot1.inverse_kinematics(v1_cmd(:,ii));
    [actuate_cmd2(:,ii),v_vector2(:,ii)]=robot2.inverse_kinematics(v2_cmd(:,ii));
    [robot1,modify_xy_cmd1(:,ii),modify_act_cmd1(:,ii)]=robot1.actuate(actuate_cmd1(:,ii),v_vector1(:,ii));
    [robot2,modify_xy_cmd2(:,ii),modify_act_cmd2(:,ii)]=robot2.actuate(actuate_cmd2(:,ii),v_vector2(:,ii));
    new_pos1=robot1.update_position(time_step);
    new_pos2=robot2.update_position(time_step);
    robot1=robot1.move_GBM(new_pos1,[robot1.theta_f; robot1.theta_r]);
    robot2=robot2.move_GBM(new_pos2,[robot2.theta_f; robot2.theta_r]);
    robot1.collision_bool=detect_collision(robot1,robot2);
    robot2.collision_bool=robot1.collision_bool;
    robot1.draw_collision_pos
    robot2.draw_collision_pos
    robot1_state(:,ii)=robot1.local_motion;
    robot2_state(:,ii)=robot2.local_motion;
    pause(0.01)
    if rem(ii,40)==0
        hold on
        scatter(robot1.center_position(1),robot1.center_position(2),'g.')
        scatter(robot2.center_position(1),robot2.center_position(2),'b.')
        hold off
    end
   % frames{ii}=getframe(gcf);
end

t=time_step:time_step:steps*time_step;
figure(2)
plot(t,v2_cmd(1,:),t,robot2_state(1,:),t,v2_cmd(2,:),t,robot2_state(2,:),t,v2_cmd(3,:),t,robot2_state(3,:))
legend('v_2 cmd_X','robot_2 state_X','v_2 cmd_Y','robot_2 state_Y','v_2 cmd_w','robot_2 state_w')
figure(3)
for ii=1:4
    plot(t,actuate_cmd2(ii,:),t,modify_act_cmd2(ii,:))
    hold on
end
legend('v_f','mv_f','theta_f','mtheta_f','v_r','mv_r','theta_r','mtheta_r')
hold off

figure(4)
plot(t,angular_error)


% video=VideoWriter('given_random_Vcommand.avi');
% open(video)
% for ii=1:steps
%     writeVideo(video,frames{ii});
% end
% close(video)