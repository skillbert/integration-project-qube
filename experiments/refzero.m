
h=0.01;
T=15;
timesraw=0:h:T;

steptime=5;

amplitude=0.5;
u=[
    zeros(4,length(timesraw))
];
simin=[timesraw',u'];