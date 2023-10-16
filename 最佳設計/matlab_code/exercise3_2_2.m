syms x1 x2
f=(1.5-x1+x1.*x2).^2+(2.25-x1+x1.*x2.^2).^2+(2.625-x1+x1.*x2.^3).^3;
df1=diff(f,x1);
df2=diff(f,x2);
ii=-4.5;
n=1;
results=zeros(4,200);
while ii<=4.5
    jj=-4.5;
    newdf1=subs(df1,x2,ii);
    newdf2=subs(df2,x2,ii);
    while jj<=4.5
        x1slope=double(subs(newdf1,x1,jj));
        x2slope=double(subs(newdf2,x1,jj));
        if x1slope<0 && x1slope<-100000
            jj=jj+1;
        elseif x1slope<0 % && x2slope<0
            jj=jj+0.1;
        elseif x1slope>=0 % ||x2slope>=0
            if x2slope==0
                results(1,n)=jj;
                results(2,n)=ii;
                results(3,n)=x1slope;
                results(4,n)=x2slope;
                n=n+1;
            end
            break
        end
        % if x1slope<100 && x1slope>-100 && x2slope<100 && x2slope>100
        %     results(1,n)=jj;
        %     results(2,n)=ii;
        %     results(3,n)=x1slope;
        %     results(4,n)=x2slope;
        %     n=n+1;
        % end
    end
    if (x2slope<0 && x2slope<-100000) || x2slope>100000
        ii=ii+1;
    else
        ii=ii+0.1;
    end
end