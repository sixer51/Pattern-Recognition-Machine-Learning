function Pw=priorP(n)
    sum=0;
    Pw=zeros(1,n);
    for i=1:n-1
         Pw(i)=round(10*(1-sum)*rand())/10;
         sum=sum+Pw(i);
    end
    Pw(n)=1-sum;
end