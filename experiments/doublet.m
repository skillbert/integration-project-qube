
h=0.05;
T=20;
timesraw=0:h:T;

signaltime=1;

amplitude=0.02;

u=zeros(length(timesraw),1);

nsamplecycle=signaltime/h;
dutysamples=ceil(nsamplecycle*0.07);

for i=1:length(u)-1
    samplet=timesraw(i);
    subi=mod(i,nsamplecycle);
    if subi<dutysamples
        u(i)=amplitude;
    elseif subi<dutysamples*2
        u(i)=-amplitude;
    else
        u(i)=0;
    end
end

simin=[timesraw',u];

plot(timesraw,u)