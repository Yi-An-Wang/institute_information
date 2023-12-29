delt2=1+2i;
delt3=2+3i;
delt4=3+2i;
ap2=pi/4;
ap3=0;
ap4=-pi/4;
T2=[exp(ap3*1i)-1 delt3; exp(ap4*1i)-1 delt4];
T3=[exp(ap2*1i)-1 delt2; exp(ap4*1i)-1 delt4];
T4=[exp(ap2*1i)-1 delt2; exp(ap3*1i)-1 delt3];
D2=det(T2);
D3=-det(T3);
D4=det(T4);
D1=-D2-D3-D4;
disp(['   ','Delta_1','            ','Delta_2'...
    ,'            ','Delta_3','            ','Delta_4'])
disp([D1 D2 D3 D4])
%% solve W,Z and check
be2=60/180*pi;
be3=68.1050/180*pi;
be4=55.5630/180*pi;

A=[exp(1i*be2)-1 exp(1i*ap2)-1; ...
   exp(1i*be3)-1 exp(1i*ap3)-1];
x=A^-1*[delt2; delt3];
disp(x)

A2=[exp(1i*be3)-1 exp(1i*ap3)-1; ...
   exp(1i*be4)-1 exp(1i*ap4)-1];
x2=A2^-1*[delt3; delt4];
disp(x2)

A3=[exp(1i*be2)-1 exp(1i*ap2)-1; ...
   exp(1i*be4)-1 exp(1i*ap4)-1];
x3=A3^-1*[delt2; delt4];
disp(x3)

W=abs(x(1));
angle_W=atan2(imag(x(1)),real(x(1)));
Z=abs(x(2));
angle_Z=atan2(imag(x(2)),real(x(2)));

%% print
disp('length of W & Z :')
disp([W,Z])
disp('angle of W & Z :')
disp([angle_W/pi*180,angle_Z/pi*180])