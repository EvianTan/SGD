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
TTPY=zeros(size(PX1));
for i=1:10
    TTPY=TTPY+PY{i};
    contour(PX1,PX2,exp(-PY{i}),'LineWidth',2)
    hold on
    contour(PX1,PX2,exp(-TTPY),'LineWidth',2)
    contour(PX1,PX2,exp(-TPY),'b','LineWidth',4)
    hold off
    M(i)=getframe;
    pause;
end
points=zeros(2,100);
eta=0.1;
for i=1:99
    id=randi(10,1,1);
    tx=x(id,:);
    ty=y(id);
    grad=2*(tx'*tx*points(:,i)-ty.*tx');
    points(:,i+1)=points(:,i)-eta*grad;
    contour(PX1,PX2,exp(-PY{id})*10,'LineWidth',2)
    hold on
    contour(PX1,PX2,exp(-TPY),'LineWidth',4)
    plot(points(1,1:i),points(2,1:i),'r','LineWidth',2);
    plot(points(1,i:i+1),points(2,i:i+1),'g','LineWidth',4);
    hold off
    M(i)=getframe;
    if i<=5 
        pause;
    else
        pause(1);
    end
end
