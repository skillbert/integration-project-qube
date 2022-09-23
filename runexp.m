function runexp(configname)

global datasetname
%fixpath
%TODO inline these vars
run hardware/hwinit;

h=0.01;%sampling time
T=10;%experiment time

run(sprintf('experiments/%s',configname));
sim('hardware/qubetemplate',T);
signalnames={'','pitch','','','motor1','motor2'};
plot(simout.time,[simout.data(:,1:4),simout.data(:,5:6)*100]);
legend(signalnames);

save(sprintf('data/%s/%s.mat',datasetname,configname),'simout');




