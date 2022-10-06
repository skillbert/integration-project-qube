
h=0.01;
T=15;
timesraw=0:h:T;

freq=1;

amplitude=0.02;
u=amplitude*sin(freq*timesraw*2*pi);
simin=[timesraw',u'];