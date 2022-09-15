function data=loadexp(name)
global datasetname
saved=load(sprintf('./data/%s/%s.mat',datasetname,name));
data=saved.simout.data;
