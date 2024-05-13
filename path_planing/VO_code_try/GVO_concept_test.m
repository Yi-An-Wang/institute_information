r_A=1;
r_B=1;
p_B=[3;5];
v_B=[-2;-2];
v_max=6;
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
axis([-v_max v_max -v_max v_max])
hold on
scatter(collision_information(1,:),collision_information(2,:),[],color,"filled")
xlabel("u_1=v_x")
ylabel("u_2=v_y")

alph=atan2(p_B(2),p_B(1));
bel=asin((r_A+r_B)/(p_B(1)^2+p_B(2)^2)^0.5);
x_1=linspace(0,10);
y_1=tan(alph-bel)*x_1-2*ones(1,100);
x_2=linspace(0,6);
y_2=tan(alph+bel)*x_2-2*ones(1,100);
x_1=x_1-2*ones(1,100);
x_2=x_2-2*ones(1,100);
plot(x_1,y_1,"r-",x_2,y_2,"r-")

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