datasetname='28oct_swingup';

data=loadexp('fromzero');

figure(1);
clf;
plot(data.time,data.y,'-',data.time,data.u,'--');
xlim([1,2.5]);
legend \alpha \theta u

folder = fileparts(which(mfilename));

xlabel 'time (sec)'
ylabel 'angle (rad)'
title 'Pendulum swingup'
saveas(gcf,[folder,'/swingup.eps'],'epsc');



figure(2);
clf;
data=loadexp('bully');

plot(data.time,data.y,'-',data.time,data.u,'--');
% xlim([1,2.5]);
legend \alpha \theta u

folder = fileparts(which(mfilename));

xlim([2.5 5.5]);
xlabel 'time (sec)'
ylabel 'angle (rad)'
title 'Pendulum fall recovery'
saveas(gcf,[folder,'/swingupflip.eps'],'epsc');


