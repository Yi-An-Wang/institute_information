u_vx=linspace(0,4,201);
u_phi=linspace(-pi/6,pi/6,201);
tt=linspace(0,3,301);
d_min=zeros(201,201);

p_B=[3;5];
v_B=[-2;-2];
r_A=1;
r_B=1;

n=1;
for ii=1:201
    vx=u_vx(ii);
    for jj=1:201
        phi=u_phi(jj);
        A=[1./tan(phi)*sin(vx.*tt.*tan(phi));...
        -1./tan(phi)*cos(vx.*tt(ii).*tan(phi))+1./tan(phi)*ones(1,size(tt,2))];
        B=p_B+v_B.*tt;
        d_p=A-B;
        d=diag((d_p'*d_p).^0.5);
        d_min(n)=min(d);
        n=n+1;
    end
end

%%
collision=100*ones(3,201*201);
k=1;
for ii=1:201
    for jj=1:201
        if d_min(ii,jj)<=(r_A+r_B)
            collision(1,k)=u_vx(ii);
            collision(2,k)=u_phi(jj);
            collision(3,k)=d_min(ii,jj);
            k=k+1;
        end
    end
end
collision(:,k:end)=[];

[U_phi,U_vx]=meshgrid(u_phi,u_vx);
scatter3(U_vx,U_phi,d_min,"MarkerEdgeColor",[0 1 0],"MarkerFaceColor",[0.3 0.8 0])
hold on
scatter3(collision(1,:),collision(2,:),collision(3,:),'MarkerEdgeColor',[1 0 1],"MarkerFaceColor",[1 0 0])
xlabel("v_x")
ylabel("phi")
zlabel("d_{min}")