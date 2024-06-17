clear all
close all
clc
Area_X=1500;
Area_Y=1500;
figure('Position',[10 10 1200 1000])
axis([-(Area_X+1) (Area_X+1) -(Area_Y+1) (Area_Y+1)])
grid on

%% destination
% destination=[100; 900];
% destination=[900 900 -900 -900 900; 0 900 900 -900 -900];
destination=2000*(rand(2,5)-rand(2,5));
% destination=[500+900*cos(pi/2:-pi/3:-7*pi/2); -500+900*sin(pi/2:-pi/3:-7*pi/2)];
goal_order=1;
goal_number=size(destination,2);

hold on 
scatter(destination(1,:),destination(2,:),'rx')
hold off

%% command initialize
max_robot_speed=30; % unit: cm
time_step=0.05;
max_steps=6000;
robot_V_cmd=zeros(3,max_steps);

v_theta_cmd=zeros(4,max_steps);
xy_cmd=zeros(4,max_steps);
v_theta_act=zeros(4,max_steps);
xy_act=zeros(4,max_steps);
robot1_state=zeros(3,max_steps);

% for pid
angular_error=zeros(1,max_steps);
previous_error=0;
error_diff=zeros(1,max_steps);
sum_error=zeros(1,max_steps);

%% senerial
robot1=rectangular_GBM([0; 0; 0],100,50,58,[0.15 0.7 0.3],[0;0;0;0]);

ii=0;
while ii<max_steps
    ii=ii+1;
    % construct velocity cmd
    destination_vector=(destination(:,goal_order)-robot1.center_position);
    theta=robot1.GBM_pos(3);
    best_unit=[cos(theta) sin(theta); -sin(theta) cos(theta)]*destination_vector/(dot(destination_vector,destination_vector))^0.5;
    angular_error(ii)=atan2(robot1.local_motion(2),robot1.local_motion(1));
%     if robot1.local_motion(1)==0 && robot1.local_motion(2)==0
%         angular_error(ii)=0;
%     elseif robot1.local_motion(1)==0 && robot1.local_motion(2)<0
%         angular_error(ii)=-pi/2;
%     elseif robot1.local_motion(1)==0 && robot1.local_motion(2)>0
%         angular_error(ii)=pi/2;
%     else
%         angular_error(ii)=atan(robot1.local_motion(2)/robot1.local_motion(1));
%     end
    % angular_error(ii)=-rem(robot1.GBM_pos(3),pi)+atan2(destination_vector(2),destination_vector(1));
    % angular_error(ii)=0.01*robot1.local_motion(2);
    error_diff(ii)=(angular_error(ii)-previous_error)/time_step;
    previous_error=angular_error(ii);
    if ii==1
        sum_error(ii)=angular_error(ii)*time_step;
    else
        sum_error(ii)=sum_error(ii-1)+angular_error(ii)*time_step;
    end
%     kp=0.2;
%     kd=0.0;
%     ki=0.0;
    kp=0.5;
    kd=0.0;
    ki=0.0;
    % kp=0.2;
    % kd=4.0;
    % ki=0.00;
    angular_cmd=kp*angular_error(ii)+kd*error_diff(ii)+ki*sum_error(ii);
    
%     if ((robot1.center_position(1)-destination(1,goal_order))^2+(robot1.center_position(2)-destination(2,goal_order))^2)^0.5<=50
%         robot_speed=max_robot_speed*0.2;
%     else
%         robot_speed=max_robot_speed;
%     end
    robot_V_cmd(1,ii)=max_robot_speed*best_unit(1);
    robot_V_cmd(2,ii)=max_robot_speed*best_unit(2);
    robot_V_cmd(3,ii)=angular_cmd;

    % move the robot
    [v_theta_cmd(:,ii),xy_cmd(:,ii)]=robot1.inverse_kinematics(robot_V_cmd(:,ii));
    [robot1,xy_act(:,ii),v_theta_act(:,ii)]=robot1.actuate(v_theta_cmd(:,ii),xy_cmd(:,ii));
    new_pos=robot1.update_position(time_step);
    robot1=robot1.move_GBM(new_pos,[robot1.theta_f; robot1.theta_r]);
    robot1_state(:,ii)=robot1.local_motion;

    % detect collision

    % visualize
    pause(0.01)
    if rem(ii,40)==0
        hold on
        scatter(robot1.center_position(1),robot1.center_position(2),'g.')
        hold off
    end
    
    % detect goal
    if ((robot1.center_position(1)-destination(1,goal_order))^2+(robot1.center_position(2)-destination(2,goal_order))^2)<=1
        goal_order=goal_order+1;
        if goal_order>goal_number
            break
        end
    end
end

%% romove zero elements
t_max=max_steps*time_step;
for ii=1:max_steps
    if robot_V_cmd(1,ii)==0 && robot_V_cmd(2,ii)==0 && robot_V_cmd(3,ii)==0
        robot_V_cmd(:,ii:end)=[];
        v_theta_cmd(:,ii:end)=[];
        xy_cmd(:,ii:end)=[];
        v_theta_act(:,ii:end)=[];
        xy_act(:,ii:end)=[];
        angular_error(:,ii:end)=[];
        error_diff(:,ii:end)=[];
        sum_error(:,ii:end)=[];
        robot1_state(:,ii:end)=[];
        t_max=(ii-1)*time_step;
        break
    end
end

%% plot data
t=time_step:time_step:t_max;
figure(2)
h1=plot(t,robot_V_cmd(1,:),'m',t,robot_V_cmd(2,:),'c',t,robot_V_cmd(3,:),'k');
set(h1,'LineStyle','-.','LineWidth',2);
hold on
h2=plot(t,robot1_state(1,:),'r',t,robot1_state(2,:),'b',t,robot1_state(3,:),'g');
set(h2,'LineStyle','-','LineWidth',1);
hold off
legend('cmd V_x','cmd V_y','cmd w','act _V_x','act V_y','act w')
title("robot1 V vector")

figure(3)
hold on
g1=plot(t,v_theta_cmd(1,:),'Color',"#77AC30","LineStyle","-.","LineWidth",2);
g2=plot(t,v_theta_cmd(3,:),"Color","#7E2F8E","LineStyle","-.","LineWidth",2);
g3=plot(t,v_theta_act(1,:),"Color","#00FF00","LineStyle",'-','LineWidth',1);
g4=plot(t,v_theta_act(3,:),"Color","#FF00FF","LineStyle",'-','LineWidth',1);
hold off
legend('cmd v_f','cmd v_r','act v_f','act v_r')
title("robot1 wheel speeds")

figure(4)
hold on
g5=plot(t,v_theta_cmd(2,:),'Color',"#00FFFF","LineStyle","-.","LineWidth",2);
g6=plot(t,v_theta_cmd(4,:),"Color","#D95319","LineStyle","-.","LineWidth",2);
g7=plot(t,v_theta_act(2,:),"Color","#0000FF","LineStyle",'-','LineWidth',1);
g8=plot(t,v_theta_act(4,:),"Color","#FF0000","LineStyle",'-','LineWidth',1);
hold off
legend({'cmd $\theta_f$','cmd $\theta_r$','act $\theta_f$','act $\theta_r$'},"Interpreter","latex")
title("robot1 wheel steering")

figure(5)
grid on
hold on
%　plot(t,v_theta_cmd(3,:),"Color",'g','LineStyle','-.','LineWidth',2)
plot(t,angular_error,"Color",'b','LineStyle','-','LineWidth',1)
hold off
% legend('cmd','error')
title("control out/in")