x=(rand(10,2)*2-1);
b=rand(2,1);
y=x*b+rand(10,1)*.3;
lambda=1.5;

px1=-2:.01:2;
px2=-2:.01:2;
[PX1,PX2]=meshgrid(px1,px2);

PY=cell(1,10);
TPY=zeros(size(PX1));
for i=1:10
    PY{i}=(y(i)-x(i,1).*PX1-x(i,2).*PX2).^2+...
        lambda*abs(PX1)/10+lambda*abs(PX2)/10;
    TPY=TPY+PY{i};
end
TTPY=zeros(size(PX1));
for i=1:10
    TTPY=TTPY+PY{i};
    contour(PX1,PX2,exp(-PY{i} ),'LineWidth',2)
    hold on
    contour(PX1,PX2,exp(-TTPY),'LineWidth',2)
    contour(PX1,PX2,exp(-TPY),'b','LineWidth',4)
    axis([-1,1,-2,2]);
    hold off
    M(i)=getframe;
%     pause(1);
end
w=zeros(2,100);
eta=0.1;
u=0;
q=0;
for i=1:99
    # parallel map
    n=size(x,1);
    id=randi(n,1,1);
    tx=x(id,:);
    ty=y(id);
    u=u+lambda*eta/n;
    grad=2*(tx'*tx*w(:,i)-ty.*tx');
    w(:,i+1)=global_w(:,i)-eta*grad;
    z=w(:,i+1);
    w(:,i+1)=max(0,w(:,i+1)-(u+global_q))...
        -max(0,-w(:,i+1)-(u-global_q));
    q=global_q+(w(:,i+1)-z);
	#deltaw=w(:,i+1)-w(:,i)
	#deltaq=q-q
	# finish parallel
	#dw,dq=reduce(deltaw, deltaq, a+b)/num_node
	# master
	#global_w=global_w+dw
	#global_q=global_q+dq
	
	# plot
    contour(PX1,PX2,exp(-PY{id})*10,'LineWidth',2)
    hold on
    contour(PX1,PX2,exp(-TPY),'LineWidth',4)
    plot(w(1,1:i),w(2,1:i),'r','LineWidth',2);
    plot(w(1,i:i+1),w(2,i:i+1),'g','LineWidth',4);
    axis([-1,1,-2,2]);
    hold off
    M(i)=getframe;
    if i<=0 
        pause;
    else
%         pause(1);
    end
end