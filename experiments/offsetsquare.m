
T=15;
timesraw=0:h:T;

steptime=3;

amplitude=0.3;
u=amplitude*square(1/steptime*timesraw*2*pi);
simin=[timesraw',u'];