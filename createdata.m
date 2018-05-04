function dataset=createdata(means)
    m=length(means);
   %% �����������������
    covs=eye(m)*sprandsym(m,3);
    while(prod((1:m)'.*(eig(covs)>0))==0)
        covs=eye(m)*sprandsym(m,3)/10;
    end
    dataset= mvnrnd(means, covs, 100);
end