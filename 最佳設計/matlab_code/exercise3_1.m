x1=linspace(-10,10);
x2=linspace(-10,10);
x1=x1';
x2=x2';
[X1,X2]=meshgrid(x1,x2);
f=(X1+2*X2-7).^2+(2*X1+X2-5).^2;
contour(X1,X2,f,[0,100,200,500,1000],'ShowText','on')
hold on
syms x1 x2
f=(x1+2*x2-7).^2+(2*x1+x2-5).^2;
df1=diff(f,x1);
df2=diff(f,x2);
R=solve(df1,df2,0,0);
solution=[double(R.x1) double(R.x2)];
scatter(solution(1),solution(2),"+")
