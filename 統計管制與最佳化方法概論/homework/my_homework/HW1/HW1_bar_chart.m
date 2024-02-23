freq1=zeros(38,3);
freq2=zeros(8,3);
for ii=2:4
    freq1(:,ii-1)=xlsread("hw_1.xlsx",ii,'Q2:Q39');
    freq2(:,ii-1)=xlsread("hw_1.xlsx",ii,'T2:T9');
end
figure(1)
bar3(1:38,freq1,1)
title('Comparison of appearance frequencies between different draw numbers 1')
axis square
set(gca,'XTickLabel',[50,100,500])
figure(2)
bar3(1:8,freq2,1)
title('Comparison of appearance frequencies between different draw numbers 2')
axis square
set(gca,'XTickLabel',[50,100,500])