function [u, err,e] = swinguptest(x,swingupinputs,ulast)

%generated in EOM_script.m
stepx=@(in1,u,step)[in1(1,:)+in1(3,:).*step;in1(2,:)+step.*in1(4,:);in1(3,:)-(step.*(in1(1,:).*-1.006565242172276e+41-in1(3,:).*1.274172028168477e+40+u.*4.205760952883568e+42+in1(4,:).^2.*sin(in1(2,:)).*2.857562576941768e+39+cos(in1(2,:)).*sin(in1(2,:)).*3.418620595097408e+41+in1(4,:).*cos(in1(2,:)).*2.833197082036257e+38))./(cos(in1(2,:)).^2.*2.962107549268906e+39-5.836534761570232e+39);in1(4,:)+(step.*(in1(4,:).*2.461853575243799e+58+sin(in1(2,:)).*2.970546379496425e+61-in1(1,:).*cos(in1(2,:)).*4.438876979100076e+60-in1(3,:).*cos(in1(2,:)).*5.619002769303141e+59+u.*cos(in1(2,:)).*1.854708934024333e+62+in1(4,:).^2.*cos(in1(2,:)).*sin(in1(2,:)).*1.26016359473634e+59))./(cos(in1(2,:)).^2.*1.26016359473634e+59-2.483025515990895e+59)];
energy=@(in1)cos(in1(2,:)).*(-1.447956e-2)+in1(3,:).^2.*8.67e-5+in1(4,:).^2.*6.0516e-5+in1(3,:).*in1(4,:).*cos(in1(2,:)).*1.2546e-4+1.447956e-2;
massoffset=@(in1)in1(1,:).*2.122850434232056e-3+sin(in1(2,:)).*1.2546e-4;

etarget=energy([0;pi;0;0]);

steptime=0.01;
scorebest=1000000;
ubest=0;

Q=0.005;
R=1000;
Rdot=1;

% scores=zeros(size(swingupinputs,2),1);
i=1;
clc
for useq=swingupinputs
    xend=x;
    xprogress=[];
    score=0;
    for u=useq'
        xend=stepx(xend,u,steptime);
        xprogress=[xprogress,xend];
        score=score+abs(energy(xend)-etarget);
        score=score+u'*Q*u;
        mo=massoffset(xend);
        score=score+mo^2*R;
    end
    
    uchange=abs(ulast-u);
    score=score+uchange^2*Rdot;

    if score<scorebest
        ubest=useq(1);
        scorebest=score;
    end
%     scores(i)=score;
    i=i+1;

%     times=0:steptime:(length(useq)-1)*steptime;
%     figure(1);
%     clf;
%     plot(times,useq,'--');
%     hold on;
%     plot(times,[xprogress(1:2,:)',xprogress(3:4,:)'*0.1]);
%     legend u a th adot thdot
%     disp(score);
%     qq=1;
end

e=energy(x)/etarget;
err=massoffset(x);
u=ubest;