
T = 20 ;
h = 0.02  ;% sampling time

sampleamount = T/h;

amplitude = 0.02;
Range = [-amplitude,amplitude];
Band = [0 1/2];
u = idinput(sampleamount,'prbs',Band,Range);
t = 1:1:length(u);
t = t*h;

simin = [t',u];