datasetname='13oct_controller';

data=loadexp('refsquare');

figure(1);
plot(data.time,data.y);

figure(2);
plot(data.time,data.obs);