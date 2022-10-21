%% raw data part
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


%% observer part
datasetname ='21oct_observer';
data=loadexp('obsverify');


figure(1);
clf
stairs(data.time,data.y(:,1));
hold on
plot(data.time,data.obs(:,1));
xlim([0.7627    1.0874]);
saveas(gcf,[folder,'/xobs.eps']);

figure(2);
clf
stairs(data.time(1:end-1),diff(data.y(:,1)/data.h));
hold on
plot(data.time(1:end-1),data.obs(1:end-1,3));
legend naive observer
% xlim([4.6643    5.3725]);
% ylim([-2.5953    3.0806]);

xlim([0.7627    1.0874]);
% saveas(gcf,[folder,'/xdotobs.eps']);

