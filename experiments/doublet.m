
h=0.02;
T=15;
timesraw=0:h:T;

signaltime=1;

amplitude=0.02;

u=zeros(length(timesraw));

for i=1:length(u)
    samplet=timesraw(i);
    duty=mod(samplet,signaltime);
    if duty<0.05
        u(i)=amplitude;
    elseif duty<0.10
        u(i)=-amplitude;
    else
        u(i)=0;
    end
end

simin=[timesraw',u',zeros(size(u))'];

plot(timesraw,u)