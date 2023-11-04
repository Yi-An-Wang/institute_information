a1=linspace(0,1);
a2=linspace(0,1);
n=size(a1,2);
apha=cell(n,n);
for aa=1:n
    for bb=1:n
        apha{aa,bb}=[a1(aa); a2(bb)];
    end
end

