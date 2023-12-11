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
X=['e1^T*e2= ',num2str(e1'*e2)];
disp(X)
z_pca1=B*e1;
z_pca2=B*e2;
scatter(z_pca1,z_pca2);