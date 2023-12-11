function obj = get_obj(r)
    % objective for fmincom
    % 
    % Args:
    %     r: radius [r1, r2]
    % Return:
    %     obj: objective value

    length = 9.14;  % default lenght of element

    density = 7860;
    obj = (6*pi*r(1)^2 + 4*pi*r(2)^2*sqrt(2)) * length * density;
end