
h=0.02;
T=15;
timesraw=0:h:T;

signaltime=1;

amplitude=0.05;

u=zeros(length(timesraw),1);

for i=1:length(u)-1
    samplet=timesraw(i);
    duty=mod(samplet,signaltime);
    if duty<0.07
        u(i)=amplitude;
    elseif duty<0.14
        u(i)=-amplitude;
    else
        u(i)=0;
    end
end

simin=[timesraw',u];

plot(timesraw,u)