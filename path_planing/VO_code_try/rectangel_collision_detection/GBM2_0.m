classdef GBM2_0
    
    properties % Unit: cm
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
        v_f_x
        v_f_y
        v_r_x
        v_r_y
        local_motion=[0; 0; 0];
        collision_bool=0;

        mode=[1 -1];
        wheel1_mode=1;
        wheel1_changemode=boolean(0);
        wheel2_mode=1;
        wheel2_changemode=boolean(0);

        v_f_max=100; %500 cm/s
        v_r_max=100;
        delta_v_f_max=20;
        delta_v_r_max=20;
        delta_theta_f_max=0.05;
        delta_theta_r_max=0.05;

        GBM_fig
        wheel_fig1
        wheel_fig2
    end
    
    methods
        function obj = GBM2_0(GBM_pos,D,W,L,color,initial_state)
            % parameters setting
            switch nargin
                case 6
                    obj.v_f=initial_state(1);
                    obj.theta_f=initial_state(2);
                    if obj.v_f<0
                        obj.wheel1_mode=obj.mode(2);
                    else
                        obj.wheel1_mode=obj.mode(1);
                    end
                    obj.v_r=initial_state(3);
                    obj.theta_r=initial_state(4);
                    if obj.v_r<0
                        obj.wheel2_mode=obj.mode(2);
                    else
                        obj.wheel2_mode=obj.mode(1);
                    end
                    obj.v_f_x=obj.v_f*cos(obj.theta_f);
                    obj.v_f_y=obj.v_f*sin(obj.theta_f);
                    obj.v_r_x=obj.v_r*cos(obj.theta_r);
                    obj.v_r_y=obj.v_r*sin(obj.theta_r);
                    H_for=[1/2 0 1/2 0; 0 1/2 0 1/2; 0 1/L 0 -1/L];
                    obj.local_motion=H_for*[obj.v_f_x; obj.v_f_y; obj.v_r_x; obj.v_r_y];
                otherwise
                    obj.v_f=0;
                    obj.v_r=0;
                    obj.theta_f=0;
                    obj.theta_r=0;
                    obj.v_f_x=obj.v_f*cos(obj.theta_f);
                    obj.v_f_y=obj.v_f*sin(obj.theta_f);
                    obj.v_r_x=obj.v_r*cos(obj.theta_r);
                    obj.v_r_y=obj.v_r*sin(obj.theta_r);
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
            obj.wheel_fig1.Matrix=makehgtform("translate",[obj.L/2; 0; 0])*makehgtform("zrotate",obj.theta_f);
            obj.wheel_fig2.Matrix=makehgtform("translate",[-obj.L/2; 0; 0])*makehgtform("zrotate",obj.theta_r);
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
        end

        function draw_collision_pos(obj)
            if obj.collision_bool==1
                patch('Faces',[1 2 3 4],'Vertices',obj.d_points(:,1:4)','EdgeColor','red','FaceColor','none','LineWidth',1)
                hold on
                scatter(obj.center_position(1),obj.center_position(2),'black*')
                hold off
            end
        end

        function [vtheta_cmd,xy_cmd,wheel1]=inverse_kinematics(obj,local_motion)
            % local_motion=>[v_x; v_y; omega]
            % vtheta_cmd=>[v_f; theta_f; v_r; theta_r]
            vtheta_cmd=zeros(4,1);
            H_ink=[1 0 0; 0 1 obj.L/2; 1 0 0; 0 1 -obj.L/2];
            xy_cmd=H_ink*local_motion;
            if dot([xy_cmd(1); xy_cmd(2)],[obj.v_f_x; obj.v_f_y])<0
                
            end
            vtheta_cmd(1)=(xy_cmd(1)^2+xy_cmd(2)^2)^0.5;
            vtheta_cmd(2)=atan2(xy_cmd(2),xy_cmd(1));
            vtheta_cmd(3)=(xy_cmd(3)^2+xy_cmd(4)^2)^0.5;
            vtheta_cmd(4)=atan2(xy_cmd(4),xy_cmd(3));
        end

        function mode_change=detect_mode_change(obj,xy_cmd)
            mode_change=[0 0];
            v1=[obj.v_f_x; obj.v_f_y; 0]/(obj.v_f_x^2+obj.v_f_y^2)^0.5;
            v2=[obj.v_r_x; obj.v_r_y; 0]/(obj.v_r_x^2+obj.v_r_y^2)^0.5;
            u1=[xy_cmd(1); xy_cmd(2); 0]/(xy_cmd(1)^2+xy_cmd(2)^2)^0.5;
            u2=[xy_cmd(3); xy_cmd(4); 0]/(xy_cmd(3)^2+xy_cmd(4)^2)^0.5;
            if dot(v1,u1)<0
                
            end

        end

        function global_motion=robot_v2globalv(obj,local_motion)
            T_matrix=[cos(obj.GBM_pos(3)) -sin(obj.GBM_pos(3)) 0; sin(obj.GBM_pos(3)) cos(obj.GBM_pos(3)) 0; 0 0 1];
            global_motion=T_matrix*local_motion;
        end

        function robot_motion=global_v2robot_v(obj,global_motion)
            T_matrix=[cos(obj.GBM_pos(3)) sin(obj.GBM_pos(3)) 0; -sin(obj.GBM_pos(3)) cos(obj.GBM_pos(3)) 0; 0 0 1];
            robot_motion=T_matrix*global_motion;
        end

        function exceed_bool=check_kinematic_constraints(obj,actuators_cmd)
            exceed_bool=0;
            if actuators_cmd(1)>obj.v_f_max || actuators_cmd(3)>obj.v_r_max
                exceed_bool=1;
            elseif abs(actuators_cmd(1)-obj.v_f)>obj.delta_v_f_max || abs(actuators_cmd(3)-obj.v_r)>obj.delta_v_r_max
                exceed_bool=1;
            elseif abs(actuators_cmd(2)-obj.theta_f)>obj.delta_theta_f_max || abs(actuators_cmd(4)-obj.theta_r)>obj.delta_theta_r_max
                exceed_bool=1;
            end
%             xy_cmd=[act_cmd(1)*cos(act_cmd(2)); act_cmd(1)*sin(act_cmd(2)); act_cmd(3)*cos(act_cmd(4)); act_cmd(3)*sin(act_cmd(4))];
%             if exceed_bool==1 && xy_cmd(1)~=xy_cmd(3)
%                 % optimize the new velocity
%                 disp('wheel slip!!')
%                 H_i=[1 0 0; 0 1 obj.L/2; 1 0 0; 0 1 -obj.L/2];
%                 H_f=[1/2 0 1/2 0; 0 1/2 0 1/2; 0 1/obj.L 0 -1/obj.L];
%                 xy_cmd=H_i*H_f*xy_cmd;
%                 act_cmd(1)=(xy_cmd(1)^2+xy_cmd(2)^2)^0.5;
%                 act_cmd(2)=atan2(xy_cmd(2),xy_cmd(1));
%                 act_cmd(3)=(xy_cmd(3)^2+xy_cmd(4)^2)^0.5;
%                 act_cmd(4)=atan2(xy_cmd(4),xy_cmd(3));
%             end
        end

        function value=min_function(obj,act,cmd,w)
            H_f=[1/2 0 1/2 0; 0 1/2 0 1/2; 0 1/obj.L 0 -1/obj.L];
            value=w*(H_f*(cmd-act)).^2;
        end

        function [c,ceq]=nonlcon_function(obj,act)
            ceq=[];
            c(1)=act(1)^2+act(2)^2-obj.v_f_max^2;
            c(2)=act(3)^2+act(4)^2-obj.v_r_max^2;
            c(3)=((act(1)^2+act(2)^2)^0.5-obj.v_f)^2-obj.delta_v_f_max^2;
            c(4)=(atan2(act(2),act(1))-obj.theta_f)^2-obj.delta_theta_f_max^2;
            c(5)=((act(3)^2+act(4)^2)^0.5-obj.v_r)^2-obj.delta_v_r_max^2;
            c(6)=(atan2(act(4),act(3))-obj.theta_r)^2-obj.delta_theta_r_max^2;
        end

        function [xy_act, vtheta_act]=find_optimized_velocity(obj,xy_cmd)
            cmd=xy_cmd;
            w=[0.5 0.5 1+(obj.local_motion(1)^2+obj.local_motion(2)^2)^0.5/50];
            % w=[0.1 0.1 0];
            fun=@(act) obj.min_function(act,cmd,w);
            A=[];
            b=[];
            Aeq=[1 0 -1 0];
            beq=0;
            ub=[obj.v_f_max; obj.v_f_max; obj.v_r_max; obj.v_r_max];
            lb=[-obj.v_f_max; -obj.v_f_max; -obj.v_r_max; -obj.v_r_max];
            nonlcon=@(act) obj.nonlcon_function(act);
            [act,fval,exitflag]=fmincon(fun,[obj.v_f; obj.theta_f; obj.v_r; obj.theta_r],A,b,Aeq,beq,lb,ub,nonlcon);
            disp([fval,exitflag])
            xy_act=act;
            vtheta_act=zeros(4,1);
            vtheta_act(1)=(act(1)^2+act(2)^2)^0.5;
            vtheta_act(2)=atan2(act(2),act(1));
            vtheta_act(3)=(act(3)^2+act(4)^2)^0.5;
            vtheta_act(4)=atan2(act(4),act(3));
        end

        function [obj, xy_act, vtheta_act]=actuate(obj,vtheta_cmd,xy_cmd) % there is a little runoff when changing cylinder coordinate to xy_coordinate
            vtheta_act=vtheta_cmd;
            switch nargin
                case 3
                    xy_act=xy_cmd;
                otherwise
                    xy_act=zeros(4,1);
                    xy_act(1)=vtheta_cmd(1)*cos(vtheta_cmd(2));
                    xy_act(2)=vtheta_cmd(1)*sin(vtheta_cmd(2));
                    xy_act(3)=vtheta_cmd(3)*cos(vtheta_cmd(4));
                    xy_act(4)=vtheta_cmd(3)*sin(vtheta_cmd(4));
            end
            exceed_bool=obj.check_kinematic_constraints(vtheta_cmd);
            if exceed_bool==1
                [xy_act,vtheta_act]=obj.find_optimized_velocity(xy_cmd);
            end
            obj.v_f_x=xy_act(1);
            obj.v_f_y=xy_act(2);
            obj.v_r_x=xy_act(3);
            obj.v_r_y=xy_act(4);
            obj.v_f=vtheta_act(1);
            obj.theta_f=vtheta_act(2);
            obj.v_r=vtheta_act(3);
            obj.theta_r=vtheta_act(4);
            H_for=[1/2 0 1/2 0; 0 1/2 0 1/2; 0 1/obj.L 0 -1/obj.L];
            obj.local_motion=H_for*xy_act;
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