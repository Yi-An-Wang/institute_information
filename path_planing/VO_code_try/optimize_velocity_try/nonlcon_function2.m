function [c,ceq]=nonlcon_function2(vtheta_act,vtheta_org,delta_max)
ceq=vtheta_act(1)*cos(vtheta_act(2))-vtheta_act(3)*cos(vtheta_act(4));
c(1)=(vtheta_act(1)-vtheta_org(1))^2-delta_max(1)^2;
c(2)=(vtheta_act(2)-vtheta_org(2))^2-delta_max(2)^2;
c(3)=(vtheta_act(3)-vtheta_org(3))^2-delta_max(3)^2;
c(4)=(vtheta_act(4)-vtheta_org(4))^2-delta_max(4)^2;