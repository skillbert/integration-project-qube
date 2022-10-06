
h=0.01;
T=15;
timesraw=0:h:T;

steptime=5;

amplitude=0.5;
u=[
    amplitude*square(1/steptime*timesraw*2*pi)
    zeros(3,length(timesraw))
];
simin=[timesraw',u'];