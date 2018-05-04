function data=lineardata(w,n,k)
    nf=length(w);
    data=zeros(n,nf+1);
    for i=1:n
        x=(20*rand(1,nf)-10)*k;
        innerproduct=dot(w,x);
        if innerproduct <= 0
            data(i,:) = [x,-1];
        else
            data(i,:) = [x,1];
        end
    end
end