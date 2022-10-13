
timesraw=0:h:T;

steptime=6;

amplitude=0.3;
u=[
    amplitude*square(1/steptime*timesraw*2*pi)
    zeros(3,length(timesraw))
];
u(:,1:1/h*2)=0;
simin=[timesraw',u'];