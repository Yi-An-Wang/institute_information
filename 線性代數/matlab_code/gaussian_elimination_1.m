A=[2 1 1; 4 -6 0; -2 7 2];
mulsb=struct("E",cell(1,size(A,1)));
k=0;
L=eye(size(A));
for ii=1:size(A,1)-1
    for jj=ii+1:size(A,1)
        k=k+1;
        c=A(jj,ii)/A(ii,ii);
        A(jj,:)=A(jj,:)-A(ii,:).*c;
        mulsb(k).E=eye(size(A));
        mulsb(k).E(jj,ii)=-c;
        L(jj,ii)=c;
    end
end