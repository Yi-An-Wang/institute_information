classdef rectangular_GBM
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        GBM_pos % [x; y ; psi]
        center_position % [x; y]
        D % GBM long
        W % GBM width
        L % wheels_distance
        d_points % detection points
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
            obj.d_points=zeros(2,5);
            obj.d_points(:,1)=obj.center_position+[D/2; W/2];
            obj.d_points(:,2)=obj.center_position+[D/2; -W/2];
            obj.d_points(:,3)=obj.center_position+[-D/2; -W/2];
            obj.d_points(:,4)=obj.center_position+[-D/2; W/2];
            obj.d_points(:,5)=obj.center_position;

            % ploting section
            obj.GBM_fig=hgtransform;
            patch(obj.d_points(1,1:4),obj.d_points(2,1:4),'Facecolor',color,'Parent',obj.GBM_fig);
            wheel_rec=[-1.5 0.5; 1.5 0.5; 1.5 -0.5; -1.5 -0.5];
            obj.wheel_fig1=hgtransform;
            patch('Faces',[1 2 3 4],'Vertices',wheel_rec,'Facecolor',[0.1 0.1 0],'Parent',obj.wheel_fig1);
            obj.wheel_fig2=hgtransform;
            patch('Faces',[1 2 3 4],'Vertices',wheel_rec,'Facecolor',[0.1 0.1 0],'Parent',obj.wheel_fig2);
            set(obj.wheel_fig1,'Parent',obj.GBM_fig)
            set(obj.wheel_fig2,'Parent',obj.GBM_fig)
            obj.wheel_fig1.Matrix=makehgtform("translate",[obj.L/2; 0; 0]);
            obj.wheel_fig2.Matrix=makehgtform("translate",[-obj.L/2; 0; 0]);
        end
        
        function obj = move_GBM(obj,new_pos,wheel_pos)
            
            translation=new_pos(1:2)-obj.center_position;
            rotation=new_pos(3)-obj.GBM_pos(3);

            % parameter setting
            obj.GBM_pos=new_pos;
            obj.center_position=new_pos(1:2);
            obj.d_points(:,1)=obj.center_position+[obj.D/2; obj.W/2];
            obj.d_points(:,2)=obj.center_position+[obj.D/2; -obj.W/2];
            obj.d_points(:,3)=obj.center_position+[-obj.D/2; -obj.W/2];
            obj.d_points(:,4)=obj.center_position+[-obj.D/2; obj.W/2];
            obj.d_points(:,5)=obj.center_position;

            % ploting section
            obj.GBM_fig
        end
    end
end

