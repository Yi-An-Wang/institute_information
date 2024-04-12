function [c,ceq]=nonlcon_function(act,v_org,delta_v_max,v_max)
ceq=[];
c(1)=act(1)^2+act(2)^2-v_max(1)^2;
c(2)=act(3)^2+act(4)^2-v_max(2)^2;
c(3)=((act(1)^2+act(2)^2)^0.5-v_org(1))^2-delta_v_max(1)^2;
c(4)=(atan2(act(2),act(1))-v_org(2))^2-delta_v_max(2)^2;
c(5)=((act(3)^2+act(4)^2)^0.5-v_org(3))^2-delta_v_max(3)^2;
c(6)=(atan2(act(4),act(3))-v_org(4))^2-delta_v_max(4)^2;