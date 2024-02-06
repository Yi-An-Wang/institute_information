classdef Differential_robot_try1
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    % Specification
        R % double
        L % double

    % Pose
        p % vector
        orientation %double

    % State
        V % heading velocity double
        omega % rotation double
        v_l % left wheel velocity double
        v_r % right wheel velocity double
        R_c % radius of curvature double

    % for ploting Appearance
        presentation % hgtransform
        color % [R G B] or 'char'
    end
    
    methods
        function obj = Differential_robot_try1(robot_radius,ini_position,ini_orientation,L,left_init_speed,right_init_speed,color)
            % Specification
            obj.R = robot_radius;
            obj.L = L;
            % Pose
            obj.p = ini_position;
            obj.orientation = ini_orientation;
            % State
            obj.v_l = left_init_speed;
            obj.v_r = right_init_speed;
            obj.V = 1/2*(obj.v_r+obj.v_l);
            obj.omega = 1/obj.L*(obj.v_r-obj.v_l);
            obj.R_c = obj.V/obj.omega;
            % Appearance
            obj.color = color;

            obj.presentation=hgtransform;
            x = obj.R*cos(linspace(0,2*pi));
            y = obj.R*sin(linspace(0,2*pi));
            patch('XData',x,'YData',y,'FaceColor',obj.color,'Parent',obj.presentation) % draw a robot
            obj.presentation.Matrix = makehgtform('translate',[obj.p(1,1) ; obj.p(2,1); 0]); % show it at initial position
        end
        
        function obj = update(obj,position)
            obj.p = position;
            obj.presentation.Matrix = makehgtform('translate',[obj.p(1,1) ; obj.p(2,1); 0]);
        end

        function obj = ForwardKinematics(obj,wheelspeed)
            obj.v_l = wheelspeed(1);
            obj.v_r = wheelspeed(2);
            obj.V = 1/2*(obj.v_r+obj.v_l);
            obj.omega = 1/obj.L*(obj.v_r-obj.v_l);
            obj.R_c = obj.V/obj.omega;
        end

        function wheelspeed = InverseKinematics(obj,V,omega)
            wheelspeed(1) = V-omega*obj.L/2;
            wheelspeed(2) = V+omega*obj.L/2;
        end

        function obj = newposition(obj,delta_t)
            kapa = 1/obj.R_c;
            x = obj.p(1) + 1/kapa*(sin(obj.orientation+kapa*obj.V*delta_t)-sin(obj.orientation));
            y = obj.p(2) - 1/kapa*(cos(obj.orientation+kapa*obj.V*delta_t)-cos(obj.orientation));
            obj.orientation = obj.orientation+kapa*obj.V*delta_t;
            obj.update([x; y])
        end

        function test(obj,newcolor)
            obj.color = newcolor;
            set(obj.presentation.Children,'FaceColor',obj.color)
            obj.update([3;45])
        end
    end
end

