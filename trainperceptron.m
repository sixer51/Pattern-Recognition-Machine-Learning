for ci=1:5
%% 生成随机数据集
w0=[-2,7];
m=500;
data=lineardata(w0,m);
figure
for i=1:m
    if data(i,3)==-1
        plot(data(i,1),data(i,2),'or');
        hold on
    else
        plot(data(i,1),data(i,2),'.g');
        hold on
    end
end
%% 训练感知器
learningrate=[0.001,0.01,0.02,0.05,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,5,10,20,50,100];

    for n=1:20
        countc(n)=0;
        counttime(n)=0;
        [a,b]=size(data);
        w=ones(1,b-1);
        i=1;
        t1=clock;
        while(countc(n)<=100000 && i<a)
            if data(i,3)*dot(w,data(i,1:b-1))<=0
                t=data(i,3)*dot(w,data(i,1:b-1));
                w = w + learningrate(n) * data(i,3) * data(i,1:b-1);
                i = 1;
                countc(n) = countc(n)+1;
            else
                i = i+1;
            end
        end
        t2=clock;
        timeit(n)=etime(t2,t1);
        
        countc=countc+1;
   
%         fprintf('learningrate=');
%         disp(learningrate(n));
%         fprintf('countc=');
%         disp(countc(n));
%         fprintf('time=');
%         disp(timeit(n));
    end
%% 感知结果
    plot([5*w(2)/w(1),-5*w(2)/w(1)],[-5*w(1)/w(1),5*w(1)/w(1)],'b-');
    if ci==1
        datafinal1=[learningrate;countc;timeit];
    elseif ci==2
        datafinal2=[learningrate;countc;timeit];
    elseif ci==3
        datafinal3=[learningrate;countc;timeit];
    elseif ci==4
        datafinal4=[learningrate;countc;timeit];
    elseif ci==5
        datafinal5=[learningrate;countc;timeit];
    end
end
%% 数据处理
    datafinalavr=(datafinal1+datafinal2+datafinal3+datafinal4+datafinal5)/5;
    figure
    plot(datafinalavr(1,2:15),datafinalavr(2,2:15),'o-');