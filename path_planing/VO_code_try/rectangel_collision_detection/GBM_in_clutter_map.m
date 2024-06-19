close all
clear all
clc
plan_map=mapClutter(17,{'Box','Plus','Circle'},'MapSize',[1000 1000],'MapResolution',1);
mat=occupancyMatrix(plan_map);
map=binaryOccupancyMap(mat,1);
inflate(plan_map,60)

%% RRT
ss=stateSpaceSE2;
sv=validatorOccupancyMap(ss);
sv.Map=plan_map;
sv.ValidationDistance=1;
ss.StateBounds=[plan_map.XWorldLimits;plan_map.YWorldLimits;[-pi pi]];
planner=plannerRRT(ss,sv,MaxConnectionDistance=100);
start=[10 10 0];
goal=[999 999 0];
rng(100,"twister");
[pthObj,solnInfo]=plan(planner,start,goal);
figure(1)
hold on
show(plan_map)
% Tree expansion
plot(solnInfo.TreeData(:,1),solnInfo.TreeData(:,2),'.-')
% Draw path
plot(pthObj.States(:,1),pthObj.States(:,2),'r-','LineWidth',2)
hold off

%% set way points
way_points=(pthObj.States(:,1:2))';
way_points(:,1)=[];

%% show environment
figure('Position',[20 20 1000 800])
show(map)
grid on
goal_order=1;
goal_number=size(way_points,2);
hold on 
scatter(way_points(1,:),way_points(2,:),'rx')
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
test_robot=rectangular_GBM([10; 10; 0],100,50,58,[0.15 0.7 0.3],[0;0;0;0]);

ii=0;
while ii<max_steps
    ii=ii+1;
    % construct velocity cmd
    destination_vector=(way_points(:,goal_order)-test_robot.center_position);
    theta=test_robot.GBM_pos(3);
    best_unit=[cos(theta) sin(theta); -sin(theta) cos(theta)]*destination_vector/(dot(destination_vector,destination_vector))^0.5;
    angular_error(ii)=atan2(test_robot.local_motion(2),test_robot.local_motion(1));
    error_diff(ii)=(angular_error(ii)-previous_error)/time_step;
    previous_error=angular_error(ii);
    if ii==1
        sum_error(ii)=angular_error(ii)*time_step;
    else
        sum_error(ii)=sum_error(ii-1)+angular_error(ii)*time_step;
    end
    kp=0.1;
    kd=0.0;
    ki=0.0;
    angular_cmd=kp*angular_error(ii)+kd*error_diff(ii)+ki*sum_error(ii);
    robot_V_cmd(1,ii)=max_robot_speed*best_unit(1);
    robot_V_cmd(2,ii)=max_robot_speed*best_unit(2);
    robot_V_cmd(3,ii)=angular_cmd;

    % move the robot
    [v_theta_cmd(:,ii),xy_cmd(:,ii)]=test_robot.inverse_kinematics(robot_V_cmd(:,ii));
    [test_robot,xy_act(:,ii),v_theta_act(:,ii)]=test_robot.actuate(v_theta_cmd(:,ii),xy_cmd(:,ii));
    new_pos=test_robot.update_position(time_step);
    test_robot=test_robot.move_GBM(new_pos,[test_robot.theta_f; test_robot.theta_r]);
    robot1_state(:,ii)=test_robot.local_motion;

    % visualize
    pause(0.01)
    if rem(ii,40)==0
        hold on
        scatter(test_robot.center_position(1),test_robot.center_position(2),'g.')
    end

    % detect goal
    if ((test_robot.center_position(1)-way_points(1,goal_order))^2+(test_robot.center_position(2)-way_points(2,goal_order))^2)<=1
        goal_order=goal_order+1;
        if goal_order>goal_number
            break
        end
    end
end
hold off

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
figure(3)
h1=plot(t,robot_V_cmd(1,:),'m',t,robot_V_cmd(2,:),'c',t,robot_V_cmd(3,:),'k');
set(h1,'LineStyle','-.','LineWidth',2);
hold on
h2=plot(t,robot1_state(1,:),'r',t,robot1_state(2,:),'b',t,robot1_state(3,:),'g');
set(h2,'LineStyle','-','LineWidth',1);
hold off
legend('cmd V_x','cmd V_y','cmd w','act _V_x','act V_y','act w')
title("robot1 V vector")

figure(4)
hold on
g1=plot(t,v_theta_cmd(1,:),'Color',"#77AC30","LineStyle","-.","LineWidth",2);
g2=plot(t,v_theta_cmd(3,:),"Color","#7E2F8E","LineStyle","-.","LineWidth",2);
g3=plot(t,v_theta_act(1,:),"Color","#00FF00","LineStyle",'-','LineWidth',1);
g4=plot(t,v_theta_act(3,:),"Color","#FF00FF","LineStyle",'-','LineWidth',1);
hold off
legend('cmd v_f','cmd v_r','act v_f','act v_r')
title("robot1 wheel speeds")

figure(5)
hold on
g5=plot(t,v_theta_cmd(2,:),'Color',"#00FFFF","LineStyle","-.","LineWidth",2);
g6=plot(t,v_theta_cmd(4,:),"Color","#D95319","LineStyle","-.","LineWidth",2);
g7=plot(t,v_theta_act(2,:),"Color","#0000FF","LineStyle",'-','LineWidth',1);
g8=plot(t,v_theta_act(4,:),"Color","#FF0000","LineStyle",'-','LineWidth',1);
hold off
legend({'cmd $\theta_f$','cmd $\theta_r$','act $\theta_f$','act $\theta_r$'},"Interpreter","latex")
title("robot1 wheel steering")

figure(6)
grid on
%　plot(t,v_theta_cmd(3,:),"Color",'g','LineStyle','-.','LineWidth',2)
plot(t,angular_error,"Color",'b','LineStyle','-','LineWidth',1)
% legend('cmd','error')
title("control out/in")

