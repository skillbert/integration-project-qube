%run this sscript to go from cold boot to working simulink setup

fixpath
SYS_ID_spring
generateinputs
close all
makeobserver

mpc1=load('mpc/for_demonstration.mat').mpc1;

refstep
x0=[0;0;0;0];