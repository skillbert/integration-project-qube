
T=30;
timesraw=0:h:T;

steptime=10;

amplitude=pi/4;
u=[
    amplitude*square(1/steptime*timesraw*2*pi)
    zeros(3,length(timesraw))
];
u(:,1:1/h*4)=0;
simin=[timesraw',u'];