syms a b c d w z
A=[a 1; b 2; c 3; d 4];
eq=A*[w; z]==[5; 6; 7; 8];
solve(eq,b,c,w,z);
% make (b,c)or(a,d) and (w,z) be solve by (a,d)or(b,c)