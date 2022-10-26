function [u, err, scores,e] = swinguptest(x,swingupinputs)

%generated in EOM_script.m
stepx=@(in1,u,step)[in1(1,:)+in1(3,:).*step;in1(2,:)+step.*in1(4,:);in1(3,:)-(step.*(in1(1,:).*-2.064724515903593e+40-in1(3,:).*2.387222185084295e+39+u.*7.963623136703449e+41+in1(4,:).^2.*sin(in1(2,:)).*5.481524516364895e+38+cos(in1(2,:)).*sin(in1(2,:)).*6.557775061651173e+40+in1(4,:).*cos(in1(2,:)).*5.434785362249549e+37))./(cos(in1(2,:)).^2.*5.682068096231903e+38-1.125031217681687e+39);in1(4,:)+(step.*(in1(4,:).*4.745387869094793e+57+sin(in1(2,:)).*5.72592736448585e+60-in1(1,:).*cos(in1(2,:)).*9.105279755188871e+59-in1(3,:).*cos(in1(2,:)).*1.052747020997773e+59+u.*cos(in1(2,:)).*3.51189788110044e+61+in1(4,:).^2.*cos(in1(2,:)).*sin(in1(2,:)).*2.417311066052126e+58))./(cos(in1(2,:)).^2.*2.417311066052126e+58-4.786198204769008e+58)];
energy=@(in1)cos(in1(2,:)).*(-1.447956e-2)+in1(4,:).^2.*cos(in1(2,:)).^2.*4.041192331968186e-5+in1(4,:).^2.*sin(in1(2,:)).^2.*4.5387e-5+in1(4,:).^2.*1.5129e-5+1.447956e-2;
massoffset=@(in1)in1(1,:).*2.124094819459362e-3+sin(in1(2,:)).*1.2546e-4;

err=massoffset(x);

etarget=energy([0;pi;0;0]);

steptime=0.005;
scorebest=1000000;
ubest=0;

disp(['etarget ',num2str(etarget)]);

scores=zeros(size(swingupinputs,2),1);
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
    end
    

    if score<scorebest
        ubest=u;
        scorebest=score;
    end
    scores(i)=score;
    i=i+1;

    times=0:steptime:(length(useq)-1)*steptime;
    figure(1);
    clf;
    plot(times,useq,'--');
    hold on;
    plot(times,[xprogress(1:2,:)',xprogress(3:4,:)'*0.1]);
    plot(times,energy(xprogress)*20);
    legend u a th adot thdot energy
    disp([score,energy(stepx(x,useq(1),steptime))]);
    qq=1;
end

e=energy(x)/etarget;
uenergy=ubest;

u=uenergy;