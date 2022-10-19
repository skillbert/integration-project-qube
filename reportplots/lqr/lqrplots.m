datasetname ='23sep';
data=loadexp('zero');
folder = fileparts(which(mfilename));


stairs(data.time,data.y(:,1));

xlim([2.3190, 4.3575]);
ylim([0.6527, 0.9021]);
saveas(gcf,[folder,'/xsensor.eps']);


stairs(data.time(1:end-1),diff(data.y(:,1)/data.h));
xlim([2.3190, 4.3575]);
saveas(gcf,[folder,'/xdotsensor.eps']);