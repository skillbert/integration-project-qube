
%h=0.005;
T=15;
timesraw=0:h:T;

freq=0.1;

amplitude=1.5;
u=[amplitude*sin(freq*timesraw*2*pi)
    zeros(3,length(timesraw))];
%u(1,1:400) = 0;
simin=[timesraw',u'];