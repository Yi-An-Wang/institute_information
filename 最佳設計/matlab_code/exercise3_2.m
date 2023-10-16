x1=linspace(-4.5,4.5);
x2=linspace(-4.5,4.5);
x1=x1';
x2=x2';
[X1,X2]=meshgrid(x1,x2);
f=(1.5-X1+X1.*X2).^2+(2.25-X1+X1.*X2.^2).^2+(2.25-X1+X1.*X2.^3).^2;
contour(X1,X2,f,[0,1,5,10,50,100,500,1000,10000],'ShowText','on');
% syms x1 x2
% f=(1.5-x1+x1.*x2).^2+(2.25-x1+x1.*x2.^2).^2+(2.25-x1+x1.*x2.^3).^2;
% [y1,y2]=min(f);
% df1=diff(f,x1);
% df2=diff(f,x2);
% H=[diff(df1,x1) diff(df1,x2); diff(df2,x1) diff(df2,x2)];
% solution=[0 0];
% gate=1;
% for ii=-4.5:0.5:4.5
%     newdf1=subs(df1,x1,ii);
%     for jj=-4.5:0.1:4.5
%         newdf1=subs(newdf1,x2,jj);
%         temp=double(solve(newdf1));
%         if temp<gate
%             gate=temp;
%             solution=[ii,jj];
%     end
% end
% R=solve(df1,df2,"Real",true);
% solution=[double(R.x1) double(R.x2)];