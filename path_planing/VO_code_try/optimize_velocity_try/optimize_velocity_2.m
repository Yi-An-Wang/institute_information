L=12;
H_f=[1/2 0 1/2 0; 0 1/2 0 1/2; 0 1/L 0 -1/L];
vtheta_cmd=[-10; 0.3; -18; 0.5];
xy_cmd=zeros(4,1);
xy_act=zeros(4,1);

xy_cmd(1)=vtheta_cmd(1)*cos(vtheta_cmd(2));
xy_cmd(2)=vtheta_cmd(1)*sin(vtheta_cmd(2));
xy_cmd(3)=vtheta_cmd(3)*cos(vtheta_cmd(4));
xy_cmd(4)=vtheta_cmd(3)*sin(vtheta_cmd(4));
V_cmd=H_f*xy_cmd;
w=[0.5 0.5 (V_cmd(1)^2+V_cmd(2)^2)^0.5/40];
vtheta_org=[-9.99999972439119; 0.499998751153656; -9.99999976362084; -0.499998758334610];
delta_max=[10; 0.3; 10; 0.3];
v_max=[30; 30];
obj=@(vtheta_act) obj_function(vtheta_act,vtheta_cmd,L,w);
A=[];
b=[];
Aeq=[];
beq=[];
ub=[v_max(1); vtheta_org(2)+pi; v_max(2); vtheta_org(4)+pi];
lb=[-v_max(1); vtheta_org(2)-pi; -v_max(2); vtheta_org(4)-pi];
nonlcon=@(vtheta_act) nonlcon_function2(vtheta_act,vtheta_org,delta_max);
[vtheta_act,fval,exitflag,output]=fmincon(obj,vtheta_org,A,b,Aeq,beq,lb,ub,nonlcon);
xy_act(1)=vtheta_act(1)*cos(vtheta_act(2));
xy_act(2)=vtheta_act(1)*sin(vtheta_act(2));
xy_act(3)=vtheta_act(3)*cos(vtheta_act(4));
xy_act(4)=vtheta_act(3)*sin(vtheta_act(4));
V_act=H_f*xy_act;