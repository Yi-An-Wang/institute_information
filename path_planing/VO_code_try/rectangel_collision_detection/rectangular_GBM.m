classdef rectangular_GBM
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        GBM_pos % [x; y ; psi]
        center_position % [x; y]
        D % GBM long
        W % GBM width
        L % wheels_distance
        r % circle_radius
        d_points % detection points
        v_f
        v_r
        theta_f
        theta_r
        collision_bool=0;

        v_f_max=10;
        v_r_max=10;
        delta_v_f_max=1;
        delta_v_r_max=1;
        delta_theta_f_max=0.3;
        delta_theta_r_max=0.3;

        GBM_fig
        wheel_fig1
        wheel_fig2
    end
    
    methods
        function obj = rectangular_GBM(GBM_pos,D,W,L,color,initial_state)
            % parameters setting
            switch nargin
                case 6
                    obj.v_f=initial_state(1);
                    obj.v_r=initial_state(3);
                    obj.theta_f=initial_state(2);
                    obj.theta_r=initial_state(4);
                otherwise
                    obj.v_f=0;
                    obj.v_r=0;
                    obj.theta_f=0;
                    obj.theta_r=0;
            end
                    
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

        function actuators_cmd=inverse_kinematics(obj,local_motion)
            % local_motion=>[v_x; v_y; omega]
            % actuators=>[v_f; theta_f; v_r; theta_r]
            actuators_cmd=zeros(4,1);
            H_ink=[1 0 0; 0 1 obj.L/2; 1 0 0; 0 1 -obj.L/2];
            v_vector=H_ink*local_motion;
            actuators_cmd(1)=(v_vector(1)^2+v_vector(2)^2)^0.5;
            actuators_cmd(2)=atan2(v_vector(2),v_vector(1));
            actuators_cmd(3)=(v_vector(3)^2+v_vector(4)^2)^0.5;
            actuators_cmd(4)=atan2(v_vector(4),v_vector(3));
        end

        function global_motion=robot_v2globalv(obj,local_motion)
            T_matrix=[cos(obj.GBM_pos(3)) -sin(obj.GBM_pos(3)) 0; sin(obj.GBM_pos(3)) cos(obj.GBM_pos(3)) 0; 0 0 1];
            global_motion=T_matrix*local_motion;
        end

        function robot_motion=global_v2robot_v(obj,global_motion)
            T_matrix=[cos(obj.GBM_pos(3)) sin(obj.GBM_pos(3)) 0; -sin(obj.GBM_pos(3)) cos(obj.GBM_pos(3)) 0; 0 0 1];
            robot_motion=T_matrix*global_motion;
        end

        function [local_motion,obj]=actuate(obj,actuators_cmd)
            cmd=actuators_cmd;
            if cmd(1)>obj.v_f_max
                cmd(1)=obj.v_f_max;
            end
            if cmd(3)>obj.v_r_max
                cmd(3)=obj.v_r_max;
            end

            % check the constraint 
            if cmd(1)*cos(cmd(2))~=cmd(3)*cos(cmd(4))
                disp('wheels slip !!')
            end

            obj.v_f=cmd(1);
            obj.theta_f=cmd(2);
            obj.v_r=cmd(3);
            obj.theta_r=cmd(4);
            H_for=[1/2 0 1/2 0; 0 1/2 0 1/2; 0 1/obj.L 0 -1/obj.L];
            local_motion=H_for*cmd;
        end

        function obj=update_position(obj,delta_t)
            local_motion=[obj.v_f; obj.theta_f; obj.v_r; obj.theta_r];
            T_matrix=[cos(obj.GBM_pos(3)) -sin(obj.GBM_pos(3)) 0; sin(obj.GBM_pos(3)) cos(obj.GBM_pos(3)) 0; 0 0 1];
            global_motion=T_matrix*local_motion;
            obj.GBM_pos=obj.GBM_pos+global_motion*delta_t;
            obj.center_position=obj.GBM_pos(1:2);
            rotate_M=[cos(obj.GBM_pos(3)) -sin(obj.GBM_pos(3)); sin(obj.GBM_pos(3)) cos(obj.GBM_pos(3))];
            obj.d_points(:,1)=obj.center_position+rotate_M*[obj.D/2; obj.W/2];
            obj.d_points(:,2)=obj.center_position+rotate_M*[obj.D/2; -obj.W/2];
            obj.d_points(:,3)=obj.center_position+rotate_M*[-obj.D/2; -obj.W/2];
            obj.d_points(:,4)=obj.center_position+rotate_M*[-obj.D/2; obj.W/2];
            obj.d_points(:,5)=obj.center_position;
        end
    end
end

