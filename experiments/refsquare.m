
h=0.005;
T=15;
timesraw=0:h:T;

steptime=6;

amplitude=0.5;
u=[
    amplitude*square(1/steptime*timesraw*2*pi)
    zeros(3,length(timesraw))
];
u(:,1/h*2)
simin=[timesraw',u'];