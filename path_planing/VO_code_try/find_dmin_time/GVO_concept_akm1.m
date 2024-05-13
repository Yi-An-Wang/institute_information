r_A=1;
r_B=1;
p_B=[5;5];
v_B=[-0.2;0];
v_max=6;
v_min=0;
steering_max=pi/6;
steering_min=-pi/6;
collision_information=zeros(5,241*210);

n=1;
v=v_min:0.025:v_max;
psi=steering_min:0.005:steering_max;
for ii=1:241
    for jj=1:210
        [t,d_min,exitflag]=find_d_min(psi(jj),v(ii),p_B,v_B);
        if d_min<=(r_A+r_B)
            collision_information(:,n)=[v(ii);psi(jj);t;d_min;exitflag];
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

%%
color=max(collision_information(3,:))*ones(1,size(collision_information,2))-collision_information(3,:);
figure(1)
axis([v_min v_max steering_min steering_max])
hold on
scatter(collision_information(1,:),collision_information(2,:),[],color,"filled")
hold off

%%
figure(2)
axis([v_min-3 v_max+1 v_min-3 v_max+1])
hold on
vx=collision_information(1,:).*cos(collision_information(1,:).*collision_information(3,:).*tan(collision_information(2,:)));
vy=collision_information(1,:).*sin(collision_information(1,:).*collision_information(3,:).*tan(collision_information(2,:)));
scatter(vx,vy,[],color,"filled")

A_x=r_A*cos(linspace(0,2*pi));
A_y=r_A*sin(linspace(0,2*pi));
patch("XData",A_x,"YData",A_y,"FaceColor","green")

B_x=p_B(1)*ones(1,100)+r_B*cos(linspace(0,2*pi));
B_y=p_B(2)*ones(1,100)+r_B*sin(linspace(0,2*pi));
patch("XData",B_x,'YData',B_y,"FaceColor","red")

quiver(p_B(1),p_B(2),v_B(1),v_B(2),"b");
text(p_B(1),p_B(2),'B','Color','black','FontSize',20)
text(0,0,'A',"Color",'black','FontSize',20)
hold off

%%
figure(3)
axis([-5 6 -5 6])
hold on
patch("XData",A_x,"YData",A_y,"FaceColor","green")
t_p=linspace(0,max(collision_information(3,:)),5);
P_B_hat=p_B+v_B.*t_p;
for ii=1:5
    B_hat_x=P_B_hat(1,ii)*ones(1,100)+(r_B+r_A)*cos(linspace(0,2*pi));
    B_hat_y=P_B_hat(2,ii)*ones(1,100)+(r_B+r_A)*sin(linspace(0,2*pi));
    s=patch("XData",B_hat_x,"YData",B_hat_y,"FaceColor","magenta");
    alpha(s,0.5+ii*0.1)
end
p_Ax=1./tan(collision_information(2,:)).*sin(collision_information(1,:).*tan(collision_information(2,:)).*collision_information(3,:));
p_Ay=-1./tan(collision_information(2,:)).*cos(collision_information(1,:).*tan(collision_information(2,:)).*collision_information(3,:))+1./tan(collision_information(2,:));
scatter(p_Ax,p_Ay,[],color,"filled")
hold off