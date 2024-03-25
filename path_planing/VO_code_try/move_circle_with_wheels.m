clear
clc
Area_X=150;
Area_Y=150;
%% make a circle & rectangle
r=10; % set a radius
color1=[.5 .3 .6]; % set a color1
x=r*cos(linspace(0,2*pi));
y=r*sin(linspace(0,2*pi));

L=3;
W=1;
rec=[-W/2 -L/2; W/2 -L/2; W/2 L/2; -W/2 L/2];
color2=[.4 .3 .2];

%% build a path (ccw circle)
p_x=100*cos(linspace(0,2*pi));
p_y=100*sin(linspace(0,2*pi));
p_z=zeros(1,100);
Pos=[p_x; p_y; p_z];

%% build a orientation
phi=linspace(0,2*pi);

%% build the object
figure(1)
axis([-(Area_X+1) (Area_X+1) -(Area_Y+1) (Area_Y+1)])
grid on
circle_0=hgtransform;
patch('XData',x,'YData',y,'Facecolor',color1,'Parent',circle_0);
line=animatedline;
set(line,'Parent',circle_0)
addpoints(line,[0;0],[0;20]);

rectangle_1=hgtransform;
patch('Faces',[1 2 3 4],'Vertices',rec,'Facecolor',color2,'Parent',rectangle_1);

rectangle_2=hgtransform;
patch('Faces',[1 2 3 4],'Vertices',rec,'Facecolor',color2,'Parent',rectangle_2);
set(rectangle_1,'Parent',circle_0)
set(rectangle_2,'Parent',circle_0)
rectangle_1.Matrix=makehgtform("translate",[0; 5; 0])*makehgtform("zrotate",2*pi/100);
rectangle_2.Matrix=makehgtform("translate",[0;-5; 0])*makehgtform("zrotate",-2*pi/100);

%% move the object
for ii=1:100
    position=makehgtform("translate",Pos(:,ii))*makehgtform("zrotate",phi(ii));
    set(circle_0,'Matrix',position)
    hold on
    scatter(Pos(1,ii),Pos(2,ii),'.')
    pause(0.1)
end
hold off