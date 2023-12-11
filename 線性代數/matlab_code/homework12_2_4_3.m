[A,ATA,B,BTB]=find_AandB;
[V,D]=eig(BTB);
lambda1=max(max(D));
for ii=1:2
    if D(ii,ii)==lambda1
        e1=V(:,ii);
    else
        lambda2=D(ii,ii);
        e2=V(:,ii);
    end
end
X=['a=[',num2str(e1(1)),' ',num2str(e1(2)),']'];
disp(X)