%run this sscript to go from cold boot to working simulink setup

% adds all subfolders to path
fixpath
% runs identification code and generate linear model and model parameters
SYS_ID_spring
close all
% generates the input signals for swingup
generateinputs
% generates linear observer and lqr/lqi controller
makeobserver

% loads mpc controller
mpc1=load('mpc/for_demonstration.mat').mpc1;

% loads the step experiment config
refstep
% starting state of hardware, only used in swingup
% should be changed to pi variant if starting swingup experiment in upward
% position
x0=[0;0;0;0];
% x0=[0;pi;0;0];








