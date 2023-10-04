count=0;
M=zeros(21,7);
uu=1;
for ii=1:2^16
    c=randi([0 1],[1 7]);
    if sum(c)==2
        V=1;
        for tt=1:21
            if c==M(tt,:)
                V=0;
                continue
            end
        end
        if V==1
            M(uu,:)=c;
            uu=uu+1;
            count=count+1;
        end
    end
end
Y=M;