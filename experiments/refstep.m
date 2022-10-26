T=15;
timesraw=0:h:T;

steptime=5;
stepindexstart=steptime/h  + 1;
amplitude=0;
u=[
    zeros(4,length(timesraw))
];
u(1,stepindexstart:end) = ones(size(u(1,stepindexstart:end)))*amplitude ; 
simin=[timesraw',u'];