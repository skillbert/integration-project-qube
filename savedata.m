
signalnames={'in','alpha','theta'};
plot(simout.time,[simout.data(:,1),simout.data(:,2:3)]);
legend(signalnames);

[~,~]=mkdir(sprintf('data/%s',datasetname));
save(sprintf('data/%s/%s.mat',datasetname,configname),'simout','h');