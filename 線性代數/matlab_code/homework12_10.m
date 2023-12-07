X=linspace(-2,2,101);
Y=linspace(-2,2,101);
[x,y]=meshgrid(X,Y);
lambda=[4 2 1 0 -1 -2 -4];
for ii=1:7
    figure("Position",[40,10,500,1000])
    subplot(2,1,1)
    f=4.*x.^2+lambda(ii).*y.^2;
    surf(x,y,f)
    xlabel x
    ylabel y
    subplot(2,1,2)
    contour(x,y,f,[0 2 4 6])
    title(["f=4x^2+\lambday^2",'\lambda is',num2str(lambda(ii))])
    xlabel x
    ylabel y
    axis equal
end