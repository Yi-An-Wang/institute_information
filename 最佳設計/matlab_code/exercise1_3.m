x=linspace(-2*pi,2*pi);
a=[5 1 1; 8 2 2; 2 -3 3];
b=[5 1 1; -7 2 2; 6 3 3];
for ii=1:3
    y=a(ii,1).*sin(x.^a(ii,2)).*cos(x.^a(ii,3))+b(ii,1).*sin(x.^b(ii,2)).*cos(x.^b(ii,3));
    plot(x,y)
    hold on
end
legend('1','2','3')
hold off