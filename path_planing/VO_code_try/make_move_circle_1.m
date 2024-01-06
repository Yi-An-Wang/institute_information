clear
clc
Area_X=150;
Area_Y=150;
%% make a circle
r=10; % set a radius
color1=[.5 .3 .6]; % set a color1
color2=[.4 .3 .2];
x=r*cos(linspace(0,2*pi));
y=r*sin(linspace(0,2*pi));

%% build a path (ccw circle)
p_x=100*cos(linspace(0,2*pi));
p_y=100*sin(linspace(0,2*pi));
p_z=zeros(1,100);
Pos=[p_x; p_y; p_z];

%% method 1
figure(1)
axis([-(Area_X+1) (Area_X+1) -(Area_Y+1) (Area_Y+1)])
dot=hgtransform;
patch('XData',x,'YData',y,'Facecolor',color1,'Parent',dot);
for ii=1:100
    dot.Matrix=makehgtform('translate',Pos(:,ii));
    pause(0.01)
end

%% method 2
figure(2)
axis([-(Area_X+1) (Area_X+1) -(Area_Y+1) (Area_Y+1)])
circle=patch('XData',x,'YData',y,'Facecolor',color2);
t=hgtransform;
set(circle,'Parent',t)
for ii=1:100
    tra=makehgtform('translate',Pos(:,ii));
    set(t,'Matrix',tra);
    pause(0.01)
end