count=0;
for loop=1:10000000
    A=zeros(7);
    x=randi([1 35],[1 4]);
    y=randi([1 21],[1 3]);
    for ii=1:4
        A(ii,:)=X(x(ii),:);
    end
    for ii=1:3
        A(4+ii,:)=Y(y(ii),:);
    end
    if issymmetric(A)
        if sum(A(5:7,5:7))==2
            disp(A)
            count=count+1;
        end
    end
end