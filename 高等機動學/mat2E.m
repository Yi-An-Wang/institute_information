function ecoder=mat2E(A)
n=size(A,1);
M=zeros(1,n*(n-1)/2);
seq=1;
for ii=1:n-1
    M(seq:seq+n-1-ii)=A(ii,ii+1:n);
    seq=seq+n-ii;
end
text=sprintf('%d',M);
ecoder=bin2dec(text);