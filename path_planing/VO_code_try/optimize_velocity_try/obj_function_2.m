function length_sqr=obj_function_2(vtheta_act,vtheta_cmd,L,w)
xy_cmd=zeros(4,1);
xy_act=zeros(4,1);

xy_cmd(1)=vtheta_cmd(1)*cos(vtheta_cmd(2));
xy_cmd(2)=vtheta_cmd(1)*sin(vtheta_cmd(2));
xy_cmd(3)=vtheta_cmd(3)*cos(vtheta_cmd(4));
xy_cmd(4)=vtheta_cmd(3)*sin(vtheta_cmd(4));

xy_act(1)=vtheta_act(1)*cos(vtheta_act(2));
xy_act(2)=vtheta_act(1)*sin(vtheta_act(2));
xy_act(3)=vtheta_act(3)*cos(vtheta_act(4));
xy_act(4)=vtheta_act(3)*sin(vtheta_act(4));

H_f=[1/2 0 1/2 0; 0 1/2 0 1/2; 0 1/L 0 -1/L];
length_sqr=w*(H_f*(xy_cmd-xy_act)).^2;