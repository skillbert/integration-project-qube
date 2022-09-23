
h=0.05;
T=8;
timesraw=0:h:T;

amplitude=0.03;

u=zeros(length(timesraw),1);

startfreq=5;
endfreq=0.5;
% 
% debug=[];
% theta=0;
% for i=1:length(u)
%     alpha=i/length(u);
%     freq=alpha*endfreq+(1-alpha)*startfreq;
%     debug(end+1)=freq;
%     theta=theta+freq*h;
%     u(i)=amplitude*sin(theta);
%     u(i)=theta;
% end

u=chirp(timesraw,startfreq,T,endfreq)*amplitude;

simin=[timesraw',u'];

plot(timesraw,u)