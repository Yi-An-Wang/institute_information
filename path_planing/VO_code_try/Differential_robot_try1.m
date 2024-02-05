classdef Differential_robot_try1
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        R % double
        p % vector

        % for ploting
        presentation % hgtransform
        color % [R G B] or 'char'
    end
    
    methods
        function obj = Differential_robot_try1(robot_radius,ini_position,color)
            obj.R = robot_radius;
            obj.p = ini_position;
            obj.color = color;

            obj.presentation=hgtransform;
            x = obj.R*cos(linspace(0,2*pi));
            y = obj.R*sin(linspace(0,2*pi));
            patch('XData',x,'YData',y,'FaceColor',color,'Parent',obj.presentation) % draw a robot
            obj.presentation.Matrix = makehgtform('translate',[obj.p(1,1) ; obj.p(2,1); 0]); % show it at initial position
        end
        
        function obj = update(obj,position)
            obj.p = position;
            obj.presentation.Matrix = makehgtform('translate',[obj.p(1,1) ; obj.p(2,1); 0]);
        end
    end
end

