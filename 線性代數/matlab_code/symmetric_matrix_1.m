Symmetric(1).C=zeros(4);
Symmetric(2).C=zeros(4);
tf=1;
sf=1;
while tf==1 && sf==1
    for jj=1:2
        S=eye(4);
        R=randi([-10,10],10,1);
        for ii=1:4
            S(ii,:)=S(ii,:)*R(ii);
        end
        M=tril(randi([-10,10],4),-1);
        Symmetric(jj).C=M+M'+S;
    end
    A=Symmetric(1).C^2-Symmetric(2).C^2;
    disp(A);
    tf=issymmetric(A);
    B=Symmetric(1).C*Symmetric(2).C*Symmetric(1).C;
    disp(B);
    sf=issymmetric(B);
end