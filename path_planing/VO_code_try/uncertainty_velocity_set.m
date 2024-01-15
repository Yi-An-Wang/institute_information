v1_r=3;
v2_r=5;
k=linspace(0,2*pi);
v1=[3+v1_r*cos(k); -5+v1_r*sin(k)];
v2=[2+v2_r*cos(k); -7+v2_r*sin(k)];
figure(1)
scatter(v1(1,:), v1(2,:),'.')
hold on
scatter(v2(1,:), v2(2,:),'.')
v=zeros(2,10000);
for ii=1:100
    for jj=1:100
        v(:,jj+ii)=v1(:,ii)+v2(:,jj);
    end
end
scatter(v(1,:), v(2,:),'.')
axis([-10 20 -20 10]);
hold off