function [v_f,v_r,theta_f,theta_r]=BGM_forward_kinematic1(mode,v_global_original,v_global_new,orientation)
% if differential mode, the orientation should + pi/2
% out put v and theta still depend on the original robot coordinate
% input v is a 2*1 vector

%% internal data
delta_t=0.1; % time interval 
L=12; % distance between two wheels
H_c_BGM=[1 0 0; 0 1 L/2; 1 0 0; 0 1 -L/2]; % BGM foward kinematic matrix
H_c_diff=[1 L/2; 1 -L/2]; % Diffetential mode kinematic matrix

%% check ccw or cw
z_direction=cross([cos(orientation); sin(orientation); 0],[v_global_new; 0]);
if z_direction(3)==abs(z_direction(3))
    direction=1;
else
    direction=-1;
end
I2R_T_matrix=[cos(orientation) sin(orientation); -sin(orientation) cos(orientation)];

%% moving depend on each mode
if mode=="diff" % differential mode
    v_global_new_univector=v_global_new/(v_global_new(1)^2+v_global_new(2)^2)^0.5;
    omega=direction*acos([cos(orientation) sin(orientation)]*v_global_new_univector)/delta_t;
    v=H_c_diff*[v_global_new(1); omega];
    v_f=v(1);
    v_r=v(2);
    theta_f=pi/2;
    theta_r=pi/2;
elseif mode=="AKT" % Akerman tangential mode
    

end