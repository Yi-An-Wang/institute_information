function A=form_matrix(n)
A=zeros(n);
for ii=1:n
    text=sprintf('vertices connect to %f :',ii);
    b=input(text);
    for jj=1:size(b,2)
        A(ii,b(jj))=1;
    end
end