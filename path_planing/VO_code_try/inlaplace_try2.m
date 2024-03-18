syms v0 a0 T s kp ki kd t
% kp=1;
% ki=0.01;
% kd=0.01;
L_v=(s^2*v0*(kd+1)+s*(kp*v0+(kd+1)*a0)+ki*T)/((kd+1)*s^3+kp*s^2+ki*s);
v=ilaplace(L_v);
a=diff(v,t);
V=matlabFunction(v);
A=matlabFunction(a);
%%
delta_t=0.1;
t=linspace(0,100-0.1,1000);
V0=zeros(1,1000);
A0=zeros(1,1000);
kp_gain=1.08;
ki_gain=0.25;
kd_gain=0.4;
T=exp(0.1*t);
% T=5*ones(1,1000);
T(1,301:600)=-30*exp(0.05*t(301:600));
for ii=1:1000
    if ii<=999
        V0(ii+1)=V(T(ii),A0(ii),kd_gain,ki_gain,kp_gain,delta_t,V0(ii));
        A0(ii+1)=A(T(ii),A0(ii),kd_gain,ki_gain,kp_gain,delta_t,V0(ii));
    else
        break
    end
end

figure(1)
plot(t,V0)
figure(2)
plot(t,A0)