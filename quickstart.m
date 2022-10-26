%run this sscript to go from cold boot to working simulink setup

fixpath
SYS_ID_spring
close all
makeobserver
refzero
x0=[0;0;0;0];