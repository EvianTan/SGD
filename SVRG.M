x=(rand(10,2)*2-1);
b=rand(2,1);
y=x*b+rand(10,1)*.3;

px1=-2:.01:2;
px2=-2:.01:2;
[PX1,PX2]=meshgrid(px1,px2);

PY=cell(1,10);
TPY=zeros(size(PX1));
for i=1:10
    PY{i}=(y(i)-x(i,1).*PX1-x(i,2).*PX2).^2;
    TPY=TPY+PY{i};
end

w=zeros(2,100);
F=zeros(2,100);
g=zeros(2,100);
eta=0.1;
for i=1:33
    F(:,i)=2*(x'*x*g(:,i)-x'*y)/10;
    for j=1:3
        id=randi(10,1,1);
        tx=x(id,:);
        ty=y(id);
        grad1=2*(tx'*tx*g(:,i)-ty.*tx');
        grad2=2*(tx'*tx*w(:,(i-1)*3+j)-ty.*tx');
        ghat=F(:,i)-grad1+grad2;
        w(:,(i-1)*3+j+1)=w(:,(i-1)*3+j)-eta*ghat;
        contour(PX1,PX2,exp(-PY{id})*10,'LineWidth',2)
        hold on
        contour(PX1,PX2,exp(-TPY),'LineWidth',4)
        plot(w(1,1:(i-1)*3+j),w(2,1:(i-1)*3+j),'b','LineWidth',3);
        plot(g(1,1:i),g(2,1:i),'r','LineWidth',2);
        if i<=2
            sc=norm(F(:,i));
            quiver(g(1,i),g(2,i),-F(1,i)/sc,-F(2,i)/sc,0,'LineWidth',2);
            if j==1
                pause;
            end
            quiver(g(1,i),g(2,i),-grad1(1)/sc,-grad1(2)/sc,0,'LineWidth',2);
            if j==1
                pause;
            end
            quiver(g(1,i)-grad1(1)/sc,g(2,i)-grad1(2)/sc,...
                (-F(1,i)+grad1(1))/sc,(-F(2,i)+grad1(2))/sc,0,'LineWidth',2);
            pause;
            quiver(w(1,(i-1)*3+j),w(2,(i-1)*3+j),...
                -grad2(1)/sc,-grad2(2)/sc,0,'LineWidth',2);
            quiver(w(1,(i-1)*3+j)-grad2(1)/sc,w(2,(i-1)*3+j)-grad2(2)/sc,...
                (-F(1,i)+grad1(1))/sc,(-F(2,i)+grad1(2))/sc,0,'LineWidth',2);
            pause;
        end
        plot(w(1,(i-1)*3+j:(i-1)*3+j+1),w(2,(i-1)*3+j:(i-1)*3+j+1),'k','LineWidth',4);
        hold off
        M((i-1)*3+j)=getframe;
        if (i-1)*3+j<=8
            pause;
        end
    end
    g(:,i+1)=sum(w(:,(i-1)*3+1:i*3),2)/3;
    contour(PX1,PX2,exp(-TPY),'LineWidth',4)
    hold on
    plot(w(1,(i-1)*3+1:i*3),w(2,(i-1)*3+1:i*3),'b','LineWidth',2);
    plot(w(1,1:(i-1)*3+j+1),w(2,1:(i-1)*3+j+1),'b','LineWidth',3);
    plot(g(1,1:i),g(2,1:i),'r','LineWidth',2);
    plot(g(1,i:i+1),g(2,i:i+1),'g','LineWidth',4);
    hold off
    getframe;
    if i<=2
        pause;
    else
        pause(1);
    end

end