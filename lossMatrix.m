function loss=lossMatrix(n)
    loss=round(rand(n,n)*10);
    for i=1:n
        for j=1:n
            if(i==j)
                loss(i,j)=0;
            end
        end
    end
end