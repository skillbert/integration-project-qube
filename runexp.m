global datasetname
%fixpath
%TODO inline these vars
run hardware/hwinit;

h=0.01;%sampling time
T=10;%experiment time

run(sprintf('experiments/%s',configname));
% sim('hardware/qubetemplate',T);
sim('hardware/qubetemplate.slx',T);
signalnames={'in','alpha','theta'};
plot(simout.time,[simout.data(:,1),simout.data(:,2:3)]);
legend(signalnames);

[~,~]=mkdir(sprintf('data/%s',datasetname));
save(sprintf('data/%s/%s.mat',datasetname,configname),'simout','h');




