function [u, err,e] = swinguptest(x,swingupinputs,ulast)

%generated in EOM_script.m

stepx=@(in1,u,step)[in1(1,:)+in1(3,:).*step;in1(2,:)+step.*in1(4,:);in1(3,:)-(step.*(in1(1,:).*-1.006565242172276e+41-in1(3,:).*1.274172028168477e+40+u.*4.205760952883568e+42+in1(4,:).^2.*sin(in1(2,:)).*1.36465659451413e+39+cos(in1(2,:)).*sin(in1(2,:)).*4.946945096435073e+41+in1(4,:).*cos(in1(2,:)).*4.099802836358348e+38))./(cos(in1(2,:)).^2.*2.046984891771195e+39-4.616371218239951e+39);in1(4,:)+(step.*(in1(4,:).*1.309289158086209e+60+sin(in1(2,:)).*1.579827576821562e+63-in1(1,:).*cos(in1(2,:)).*1.425372718844358e+62-in1(3,:).*cos(in1(2,:)).*1.804324222587342e+61+u.*cos(in1(2,:)).*5.955676465922581e+63+in1(4,:).^2.*cos(in1(2,:)).*sin(in1(2,:)).*1.932457230704348e+60))./(cos(in1(2,:)).^2.*1.932457230704348e+60-4.358087827694814e+60)];
energy=@(in1)cos(in1(2,:)).*(-1.447956e-2)+in1(4,:).^2.*cos(in1(2,:)).^2.*4.038776370432646e-5+in1(4,:).^2.*sin(in1(2,:)).^2.*4.5387e-5+in1(4,:).^2.*1.5129e-5+1.447956e-2;
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