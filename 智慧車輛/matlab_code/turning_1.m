function kappa=turning_1(t)
if (t>=0 && t<=0.54) || (t>1.178 && t<=1.673) || (t>2.273 && t<=2.813)
    kappa=0;
elseif t>0.54 && t<=0.859
    kappa=1/13.09947;
elseif t>0.859 && t<=1.178
    kappa=-1/13.09947;
elseif t>1.673 && t<=1.973
    kappa=-1/10.74377;
elseif t>1.973 && t<=2.273
    kappa=1/10.74377;
end