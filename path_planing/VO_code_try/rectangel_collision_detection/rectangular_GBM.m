classdef rectangular_GBM
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        GBM_pos % [x; y ; psi]
        center_position % [x; y]
        D % GBM long
        W % GBM width
        L % wheels_distance
        r
        d_points % detection points
        collision_bool=0;
        GBM_fig
        wheel_fig1
        wheel_fig2
    end
    
    methods
        function obj = rectangular_GBM(GBM_pos,D,W,L,color)
            % parameters setting
            obj.GBM_pos=GBM_pos;
            obj.center_position=GBM_pos(1:2);
            obj.D=D;
            obj.W=W;
            obj.L=L;
            obj.r=(1/2)*(D^2+W^2)^0.5;
            obj.d_points=zeros(2,5);
            rotate_M=[cos(obj.GBM_pos(3)) -sin(obj.GBM_pos(3)); sin(obj.GBM_pos(3)) cos(obj.GBM_pos(3))];
            obj.d_points(:,1)=obj.center_position+rotate_M*[D/2; W/2];
            obj.d_points(:,2)=obj.center_position+rotate_M*[D/2; -W/2];
            obj.d_points(:,3)=obj.center_position+rotate_M*[-D/2; -W/2];
            obj.d_points(:,4)=obj.center_position+rotate_M*[-D/2; W/2];
            obj.d_points(:,5)=obj.center_position;

            % ploting section
            obj.GBM_fig=hgtransform;
            patch('Faces',[1 2 3 4],'Vertices',[D/2 W/2; D/2 -W/2; -D/2 -W/2; -D/2 W/2],'Facecolor',color,'Parent',obj.GBM_fig);
            obj.GBM_fig.Matrix=makehgtform("translate",[obj.center_position; 0])*makehgtform("zrotate",obj.GBM_pos(3));
            wheel_rec=[-1.5 0.5; 1.5 0.5; 1.5 -0.5; -1.5 -0.5];
            obj.wheel_fig1=hgtransform;
            set(obj.wheel_fig1,'Parent',obj.GBM_fig)
            patch('Faces',[1 2 3 4],'Vertices',wheel_rec,'Facecolor',[0.1 0.1 0],'Parent',obj.wheel_fig1);
            obj.wheel_fig2=hgtransform;
            set(obj.wheel_fig2,'Parent',obj.GBM_fig)
            patch('Faces',[1 2 3 4],'Vertices',wheel_rec,'Facecolor',[0.1 0.1 0],'Parent',obj.wheel_fig2);
            obj.wheel_fig1.Matrix=makehgtform("translate",[obj.L/2; 0; 0]);
            obj.wheel_fig2.Matrix=makehgtform("translate",[-obj.L/2; 0; 0]);
        end
        
        function obj = move_GBM(obj,new_pos,wheel_pos)

            % parameter setting
            obj.GBM_pos=new_pos;
            obj.center_position=new_pos(1:2);
            rotate_M=[cos(obj.GBM_pos(3)) -sin(obj.GBM_pos(3)); sin(obj.GBM_pos(3)) cos(obj.GBM_pos(3))];
            obj.d_points(:,1)=obj.center_position+rotate_M*[obj.D/2; obj.W/2];
            obj.d_points(:,2)=obj.center_position+rotate_M*[obj.D/2; -obj.W/2];
            obj.d_points(:,3)=obj.center_position+rotate_M*[-obj.D/2; -obj.W/2];
            obj.d_points(:,4)=obj.center_position+rotate_M*[-obj.D/2; obj.W/2];
            obj.d_points(:,5)=obj.center_position;

            % ploting section
            obj.wheel_fig1.Matrix=makehgtform("translate",[obj.L/2; 0; 0])*makehgtform("zrotate",wheel_pos(1));
            obj.wheel_fig2.Matrix=makehgtform("translate",[-obj.L/2; 0; 0])*makehgtform("zrotate",wheel_pos(2));
            fig_change=makehgtform("translate",[new_pos(1:2); 0])*makehgtform("zrotate",new_pos(3));
            set(obj.GBM_fig,'Matrix',fig_change)
            hold on 
            scatter(new_pos(1),new_pos(2),'.')
            % pause(0.005)
            hold off
        end

        function draw_collision_pos(obj)
            if obj.collision_bool==1
                patch('Faces',[1 2 3 4],'Vertices',obj.d_points(:,1:4)','EdgeColor','red','FaceColor','none','LineWidth',1)
                hold on
                scatter(obj.center_position(1),obj.center_position(2),'black*')
                hold off
            end
        end
    end
end

