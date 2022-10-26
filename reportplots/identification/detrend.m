
global datasetname
datasetname='20oct';
stuff = loadexp('sweep') ; 
validation_stuff= loadexp('sweep') ;

starttime = stuff.h;
startingnumber = floor(starttime / stuff.h) ;

% y = [detrend(stuff.alpha(2:end)),stuff.theta(2:end) ] ; %output
y = [stuff.alpha(2:end)-mean(stuff.alpha(2:end)),stuff.theta(2:end) ] ; %output

plot(stuff.time,stuff.alpha,'-',stuff.time,ones(size(stuff.alpha))*mean(stuff.alpha),'--');

legend '\alpha raw data' mean

folder = fileparts(which(mfilename));
saveas(gcf,[folder,'/demean.eps'],'epsc');