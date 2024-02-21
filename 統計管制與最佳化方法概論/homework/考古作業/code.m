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


C = nchoosek(38,6)*nchoosek(8,1);

total = (P1+P2+P3+P4+P5+P6+P7+P8+P9+P10)/C


