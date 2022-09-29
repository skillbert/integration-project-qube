
h=0.05;
T=8;
timesraw=0:h:T;

amplitude=0.008;

u=zeros(length(timesraw),1);

startfreq=5;
endfreq=0.5;

u=chirp(timesraw,startfreq,T,endfreq)*amplitude;

simin=[timesraw',u'];

plot(timesraw,u)