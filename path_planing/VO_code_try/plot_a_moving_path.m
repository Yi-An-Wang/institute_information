r=1;
x=r*cos(linspace(0,2*pi));
y=r*sin(linspace(0,2*pi));
A_r=20;
track_x=A_r*cos(linspace(0,2*pi));
track_y=A_r*sin(linspace(0,2*pi));

path=zeros(2,size(track_x,2));
figure(1)
h=plot(path(1,1),path(2,1),'r--');
set(gca,'XLim',[-A_r-3,A_r+3],'YLim',[-A_r-3,A_r+3])
hold on
dot=hgtransform;
patch('XData',x,'YData',y,'Facecolor','b','Parent',dot);

for ii=1:size(track_x,2)
    path(:,ii)=[track_x(ii); track_y(ii)];
    set(h,'xdata',path(1,1:ii),'ydata',path(2,1:ii));
    dot.Matrix=makehgtform('translate',[path(1,ii); path(2,ii); 0]);
    pause(0.01)
end