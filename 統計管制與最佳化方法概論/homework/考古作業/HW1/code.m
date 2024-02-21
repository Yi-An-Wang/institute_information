P1 = nchoosek(6,6)*nchoosek(1,1);
P2 = nchoosek(6,6)*nchoosek(7,1);
P3 = nchoosek(6,5)*nchoosek(32,1)*nchoosek(1,1);
P4 = nchoosek(6,5)*nchoosek(32,1)*nchoosek(7,1);
P5 = nchoosek(6,4)*nchoosek(32,2)*nchoosek(1,1);
P6 = nchoosek(6,4)*nchoosek(32,2)*nchoosek(7,1);
P7 = nchoosek(6,3)*nchoosek(32,3)*nchoosek(1,1);
P8 = nchoosek(6,2)*nchoosek(32,4)*nchoosek(1,1);
P9 = nchoosek(6,3)*nchoosek(32,3)*nchoosek(7,1);
P10 = nchoosek(6,1)*nchoosek(32,5)*nchoosek(1,1);

P_total = nchoosek(38,6)*nchoosek(8,1);

total = (P1+P2+P3+P4+P5+P6+P7+P8+P9+P10)/P_total;


% ===============================
P_A = (nchoosek(38,6)*nchoosek(4,1))/(nchoosek(38,6)*nchoosek(8,1));

P_B4 = nchoosek(19,4)*nchoosek(19,2)*nchoosek(8,1);
P_B5 = nchoosek(19,5)*nchoosek(19,1)*nchoosek(8,1);
P_B6 = nchoosek(19,6)*nchoosek(19,0)*nchoosek(8,1);
P_B = (P_B4+P_B5+P_B6)/(nchoosek(37,6)*nchoosek(8,1));

P_C =1-(nchoosek(33,6)*nchoosek(3,1))/(nchoosek(38,6)*nchoosek(8,1)); 


P_BC4 = nchoosek(19,4)*nchoosek(19,2)*nchoosek(8,1)-nchoosek(17,4)*nchoosek(16,2)*nchoosek(3,1);
P_BC5 = nchoosek(19,5)*nchoosek(19,1)*nchoosek(8,1)-nchoosek(17,5)*nchoosek(16,1)*nchoosek(3,1);
P_BC6 = nchoosek(19,6)*nchoosek(19,0)*nchoosek(8,1)-nchoosek(17,6)*nchoosek(16,0)*nchoosek(3,1);
P_BC = (P_BC4+P_BC5+P_BC6)/P_C/(nchoosek(38,6)*nchoosek(8,1));

P_AC = (nchoosek(38,6)*nchoosek(4,1)-nchoosek(33,5)*nchoosek(1,1))/(nchoosek(38,6)*nchoosek(8,1))/P_C

%======================

P12 = (nchoosek(6,6)*nchoosek(32,0))/(nchoosek(38,6)*nchoosek(8,1))*8;
P32 = (nchoosek(6,5)*nchoosek(32,1))/(nchoosek(38,6)*nchoosek(8,1))*8;
P52 = (nchoosek(6,4)*nchoosek(32,2))/(nchoosek(38,6)*nchoosek(8,1))*8;
P72 = (nchoosek(6,3)*nchoosek(32,3))/(nchoosek(38,6)*nchoosek(8,1))*8;
P82 = (nchoosek(6,2)*nchoosek(32,4))/(nchoosek(38,6)*nchoosek(8,1))*8;
P102 = (nchoosek(6,1)*nchoosek(32,5))/(nchoosek(38,6)*nchoosek(8,1))*8;

P_c_total = P12+P32+P52+P72+P82+P102