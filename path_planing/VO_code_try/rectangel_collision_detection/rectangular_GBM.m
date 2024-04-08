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
        local_motion=[0; 0; 0];
        collision_bool=0;

        v_f_max=500; %500 cm/s
        v_r_max=500;
        delta_v_f_max=100;
        delta_v_r_max=100;
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
            wheel_rec=[-15 4; 15 4; 15 -4; -15 -4];
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
            % hold on 
            % scatter(new_pos(1),new_pos(2),'.')
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

        function [actuators_cmd,v_vector]=inverse_kinematics(obj,local_motion)
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

        function obj=actuate(obj,actuators_cmd,fr_xy_cmd) % there is a little runoff when changing cylinder coordinate to xy_coordinate
            switch nargin
                case 3
                    xy_cmd=fr_xy_cmd;
                    non=0;
                otherwise
                    non=1;
            end
            exceed_bool=0;
            act_cmd=actuators_cmd;
            if actuators_cmd(1)>obj.v_f_max
                act_cmd(1)=obj.v_f_max;
                exceed_bool=1;
            end
            if actuators_cmd(3)>obj.v_r_max
                act_cmd(3)=obj.v_r_max;
                exceed_bool=1;
            end
            if abs(actuators_cmd(1)-obj.v_f)>obj.delta_v_f_max
                if actuators_cmd(1)>obj.v_f
                    act_cmd(1)=obj.v_f+obj.delta_v_f_max;
                else
                    act_cmd(1)=obj.v_f-obj.delta_v_f_max;
                end
                exceed_bool=1;
            end
            if abs(actuators_cmd(2)-obj.theta_f)>obj.delta_theta_f_max
                if actuators_cmd(2)>obj.theta_f
                    act_cmd(2)=obj.theta_f+obj.delta_theta_f_max;
                else
                    act_cmd(1)=obj.theta_f-obj.delta_theta_f_max;
                end
                exceed_bool=1;
            end
            if abs(actuators_cmd(3)-obj.v_r)>obj.delta_v_r_max
                if actuators_cmd(3)>obj.v_r
                    act_cmd(3)=obj.v_r+obj.delta_v_r_max;
                else
                    act_cmd(3)=obj.v_r-obj.delta_v_r_max;
                end
                exceed_bool=1;
            end
             if abs(actuators_cmd(4)-obj.theta_r)>obj.delta_theta_r_max
                if actuators_cmd(4)>obj.theta_r
                    act_cmd(4)=obj.theta_r+obj.delta_theta_r_max;
                else
                    act_cmd(4)=obj.theta_r-obj.delta_theta_r_max;
                end
                exceed_bool=1;
            end
            if exceed_bool==1
                % check the constraint
                if act_cmd(1)*cos(act_cmd(2))-act_cmd(3)*cos(act_cmd(4))>=1e-14
                    disp('wheel slip!!')
                end
            end
            obj.v_f=act_cmd(1);
            obj.theta_f=act_cmd(2);
            obj.v_r=act_cmd(3);
            obj.theta_r=act_cmd(4);
            if non==1 || exceed_bool==1
                xy_cmd=[act_cmd(1)*cos(act_cmd(2)); act_cmd(1)*sin(act_cmd(2)); act_cmd(3)*cos(act_cmd(4)); act_cmd(3)*sin(act_cmd(4))];
            end
            H_for=[1/2 0 1/2 0; 0 1/2 0 1/2; 0 1/obj.L 0 -1/obj.L];
            obj.local_motion=H_for*xy_cmd;
        end

        function new_pos=update_position(obj,delta_t)
            new_pos=zeros(3,1);
            new_pos(3)=obj.GBM_pos(3)+obj.local_motion(3)*delta_t;
            if obj.local_motion(3)~=0
                a=sin(obj.GBM_pos(3)+obj.local_motion(3)*delta_t)-sin(obj.GBM_pos(3));
                b=cos(obj.GBM_pos(3)+obj.local_motion(3)*delta_t)-cos(obj.GBM_pos(3));
                new_pos(1)=obj.GBM_pos(1)+obj.local_motion(1)/obj.local_motion(3)*a+obj.local_motion(2)/obj.local_motion(3)*b;
                new_pos(2)=obj.GBM_pos(2)-obj.local_motion(1)/obj.local_motion(3)*b+obj.local_motion(2)/obj.local_motion(3)*a;
            else
                new_pos(1)=obj.GBM_pos(1)+obj.local_motion(1)*delta_t*cos(obj.GBM_pos(3))-obj.local_motion(2)*delta_t*sin(obj.GBM_pos(3));
                new_pos(2)=obj.GBM_pos(2)+obj.local_motion(1)*delta_t*sin(obj.GBM_pos(3))+obj.local_motion(2)*delta_t*cos(obj.GBM_pos(3));
            end
        end
    end
end

