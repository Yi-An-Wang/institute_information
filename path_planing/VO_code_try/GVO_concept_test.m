r_A=1;
r_B=1;
p_B=[3;12];
v_B=[-2;-2];
v_max=5;
collision_information=zeros(6,201*201);

n=1;
for v_x=-v_max:0.1:v_max
    for v_y=-v_max:0.1:v_max
        v=[v_x;v_y];
        t=p_B'*(v-v_B)/((v-v_B)'*(v-v_B));
        p_shortest=t*v-p_B-t*v_B;
        d_min=(p_shortest(1)^2+p_shortest(2)^2)^0.5;
        if d_min<=(r_A+r_B) && t>0
            collision_information(:,n)=[v;t;p_shortest;d_min];
            n=n+1;
        end
    end
end

for ii=1:size(collision_information,2)
    if collision_information(1,ii)==0 && collision_information(2,ii)==0 && collision_information(3,ii)==0
        collision_information(:,ii:end)=[];
        break
    end
end

color=max(collision_information(3,:))*ones(1,size(collision_information,2))-collision_information(3,:);
figure(1)
axis([-v_max-1 v_max+1 -v_max-1 v_max+1])
scatter(collision_information(1,:),collision_information(2,:),[],color,"filled")