x1=[-3.9847,-3.5549,-1.2401,-0.9780,-0.7932,-2.8531,-2.7605,-3.7287,-3.5414,-2.2692,-3.4549,-3.0752,-3.9934, -0.9780,-1.5799,-1.4885,-0.7431,-0.4221,-1.1186,-2.3462,-1.0826,-3.4196,-1.3193,-0.8367,-0.6579,-2.9683];
x2=[2.8792, 0.7932,1.1882,3.0682,4.2532,0.3271,0.9846,2.7648,2.6588];
pw1=0.9;
pw2=0.1;
loss=[0 1;6 0]; 
mean1=mean(x1);
mean2=mean(x2);
cov1=cov(x1);
cov2=cov(x2);
x11=-20:0.01:20;
x22=-20:0.01:20;
pxw1=normpdf(x11,mean1,sqrt(cov1));
pxw2=normpdf(x22,mean2,sqrt(cov2));
plot(x11,pxw1);
hold on
plot(x22,pxw2);
xlabel('x');
ylabel('P');
title('类条件概率密度');
legend('P(x|w1)','P(x|w2)');
%% 计算后验概率/最小错误贝叶斯
pw1x=(pxw1.*pw1)./(pxw1.*pw1+pxw2.*pw2);
pw2x=(pxw2.*pw2)./(pxw1.*pw1+pxw2.*pw2);
figure
plot(x11,pw1x);
hold on
plot(x22,pw2x);
title('后验概率');
xlabel('x');
ylabel('P');
legend('P(w1|x)','P(w2|x)');
%% 最小风险贝叶斯
R1x=loss(1,2)*pw2x;
R2x=loss(2,1)*pw1x;
R=zeros(1,length(x11));
plot(x11,R1x);
hold on
plot(x22,R2x);
legend('R(a1)','R(a2)');
title('期望风险');
xlabel('x');
ylabel('R(a)');
k=0;
for i=1:length(x11)
    if(R1x(i)>R2x(i))
        R(i)=2;
    else
        R(i)=1;
    end
    if(i>1 && R(i)~=R(i-1))
        k=i;
    end
end
k=k/100-20; %决策变换点
figure
plot(x11,R);
title('最小风险贝叶斯分类决策');
figure