load('OneDimensional_data.mat');
plot(x,y,"r.")
hold on
p=polyfit(x,y,3);
x1 = linspace(0,2);
y1 = polyval(p,x1);
