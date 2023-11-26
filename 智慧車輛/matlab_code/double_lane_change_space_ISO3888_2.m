x=linspace(0,61,17821);
y_r=zeros(1,17821);
y_l=zeros(1,17821);
for ii=1:17821
    if x(ii)<25.5
        y_r(ii)=0;
    elseif x(ii)>=25.5 && x(ii)<=36.5
        y_r(ii)=3.472;
    elseif x(ii)>36.5
        y_r(ii)=-0.528;
    end
end

for ii=1:17821
    if x(ii)<12
        y_l(ii)=2.472;
    elseif x(ii)>=12 && x(ii)<=49
        y_l(ii)=6.492;
    elseif x(ii)>49
        y_l(ii)=2.472;
    end
end
figure('Position',[10,10,2000,2000])
h=plot(x,y_r,x,y_l);
axis equal
set(gca,'XLim',[0,61]);
set(h,"LineWidth",5);