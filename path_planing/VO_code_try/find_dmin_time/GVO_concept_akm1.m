r_A=1;
r_B=1;
p_B=[3;5];
v_B=[-2;-2];
v_max=6;
v_min=0;
steering_max=pi/6;
steering_min=-pi/6;
collision_information=zeros(4,241*241);

n=1;
for v=v_min:0.025:v_max
    for psi=steering_min:pi/720:steering_max
        [t,d_min,exitflag]=find_d_min(psi,v,p_B,v_B);
%         v=[v_x;psi];
%         t=p_B'*(v-v_B)/((v-v_B)'*(v-v_B));
%         p_shortest=t*v-p_B-t*v_B;
%         d_min=(p_shortest(1)^2+p_shortest(2)^2)^0.5;
        if d_min<=(r_A+r_B)
            collision_information(:,n)=[v;psi;t;d_min];
            n=n+1;
        end
    end
end

for ii=1:size(collision_information,2)
    if collision_information(1,ii)==0 && collision_information(2,ii)==0 && collision_information(3,ii)==0 && collision_information(4,ii)==0
        collision_information(:,ii:end)=[];
        break
    end
end