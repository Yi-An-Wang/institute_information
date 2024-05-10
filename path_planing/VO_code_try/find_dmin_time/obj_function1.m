function d_sqr=obj_function1(t,phi,v,p_B,v_B)
d_sqr=(1/tan(phi)*sin(v*tan(phi)*t)-p_B(1)-t*v_B(1))^2+(-1/tan(phi)*cos(v*tan(phi)*t)+1/tan(phi)-p_B(2)-t*v_B(2))^2;