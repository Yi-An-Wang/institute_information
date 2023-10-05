A=[1 3 3 2; 2 6 9 5; -1 -3 3 0];
%mulsb=struct("E",cell(1,size(A,1)));
Linver=eye(size(A,1));
L=eye(size(A,1));
k=0;
for ii=1:size(A,1)-1
    k=k+1;
    while A(ii,k)==0
        k=k+1;
    end
    for jj=ii+1:size(A,1)
        c=A(jj,k)/A(ii,k);
        A(jj,:)=A(jj,:)-A(ii,:).*c;
        E=eye(size(A,1));
        E(jj,ii)=-c;
        Linver=Linver*E;
        %mulsb(k).E=eye(size(A));
        %mulsb(k).E(jj,ii)=-c;
        L(jj,ii)=c;
    end
end