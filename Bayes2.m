n=3; %3种类型
m=2; %2维特征
data1=createdata([5,3]);
data2=createdata([3,7]);
data3=createdata([2,1]);
figure
plot(data1(:, 1), data1(:, 2), '.r');
hold on
plot(data2(:, 1), data2(:, 2), 'og');
hold on
plot(data3(:, 1), data3(:, 2), '*b');
%% 条件概率密度
mean1 = mean(data1); 
cov1 = cov(data1);
mean2 = mean(data2); 
cov2 = cov(data2);
mean3 = mean(data3); 
cov3 = cov(data3);
[x, y] = meshgrid(-4 : 0.2 : 10);
Pxw1 = reshape(mvnpdf([x(:), y(:)], mean1, cov1),size(x));
Pxw2 = reshape(mvnpdf([x(:), y(:)], mean2, cov2),size(x));
Pxw3 = reshape(mvnpdf([x(:), y(:)], mean3, cov3),size(x));
figure
surf(x,y,Pxw1);
hold on
surf(x,y,Pxw2);
hold on
surf(x,y,Pxw3);
%% 后验概率
pw=priorP(n);
pxw1_joint = Pxw1*pw(1);
pxw2_joint = Pxw2*pw(2);
pxw3_joint = Pxw3*pw(3);
pw1x = pxw1_joint./(pxw1_joint+pxw2_joint+pxw3_joint);
pw2x = pxw2_joint./(pxw1_joint+pxw2_joint+pxw3_joint);
pw3x = pxw3_joint./(pxw1_joint+pxw2_joint+pxw3_joint);
figure
surf(x,y,pw1x);
hold on
surf(x,y,pw2x);
hold on
surf(x,y,pw3x);
Region_result = zeros(size(x));
for i = 1:size(x,1)
    for j = 1:size(x,1)
        [~,Class] = min([pw1x(i,j) pw2x(i,j) pw3x(i,j)]);
        Region_result(i,j) = Class;
    end
end
figure
surface(x,y,Region_result);
%% 期望风险
loss=lossMatrix(n);
Risk1 = loss(1, 1) * pw1x + loss(1, 2) * pw2x + loss(1, 3) * pw3x;
Risk2 = loss(2, 1) * pw1x + loss(2, 2) * pw2x + loss(2, 3) * pw3x;
Risk3 = loss(3, 1) * pw1x + loss(3, 2) * pw2x + loss(3, 3) * pw3x;
figure
surf(x,y,Risk1);
hold on
surf(x,y,Risk2);
hold on
surf(x,y,Risk3);
Region_result = zeros(size(x));
for i = 1:size(x,1)
    for j = 1:size(x,1)
        [~,Class] = min([Risk1(i,j) Risk2(i,j) Risk3(i,j)]);
        Region_result(i,j) = Class;
    end
end
figure(6);
surface(x,y,Region_result);