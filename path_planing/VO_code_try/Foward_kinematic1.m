function [v_f,v_r,theta_f,theta_r]=Foward_kinematic1(orientation,V_old,V_new,mode) % Vx,Vy are vectors

delta_t=0.1;
L=12;

H_c=[1 0 0; 0 1 L/2; 1 0 0; 0 1 -L/2];

T_matrix=[cos(orientation) sin(orientation); -sin(orientation) cos(orientation)];
v_target=T_matrix*V_new;
V_old=[V_old; 0];
V_new=[V_new; 0];
z=cross(V_old,V_new);
if z(3)==abs(z(3))
    direction=1;
else 
    direction=-1;
end
if mode~="crab"
    omega=direction/delta_t*acos(dot(V_old,V_new)/(sqrt(V_old(1)^2+V_old(2)^2)*sqrt(V_new(1)^2+V_new(2)^2)));
else
    omega=0;
end
v_wheels_xy=H_c*[v_target; omega];
v_f=sqrt(v_wheels_xy(1)^2+v_wheels_xy(2)^2);
v_r=sqrt(v_wheels_xy(3)^2+v_wheels_xy(4)^2);
theta_f=atan2(v_wheels_xy(2),v_wheels_xy(1));
theta_r=atan2(v_wheels_xy(4),v_wheels_xy(3));