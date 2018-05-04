function dataset=createdata(means)
    m=length(means);
   %% 生成随机半正定矩阵
    covs=eye(m)*sprandsym(m,3);
    while(prod((1:m)'.*(eig(covs)>0))==0)
        covs=eye(m)*sprandsym(m,3)/10;
    end
    dataset= mvnrnd(means, covs, 100);
end