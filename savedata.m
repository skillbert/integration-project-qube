
%for some reason it some times adds a dimension
if length(size(simout.Data))==3
    simout.Data=reshape(simout.Data,[],length(simout.Time))';
end

signalnames={'in','alpha','theta'};
plot(simout.time,[simout.data(:,1),simout.data(:,2:3)]);
legend(signalnames);

[~,~]=mkdir(sprintf('data/%s',datasetname));
save(sprintf('data/%s/%s.mat',datasetname,configname),'simout','h');