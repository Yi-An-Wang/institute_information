function length_sqr=obj_function(act,cmd,L,w)
H_f=[1/2 0 1/2 0; 0 1/2 0 1/2; 0 1/L 0 -1/L];
length_sqr=w*(H_f*(cmd-act)).^2;