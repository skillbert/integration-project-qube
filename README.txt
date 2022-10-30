

Before opening any simulink model run 'quickstart.m' this will run
identification and configure all the controllers.

The simulink models are in hardware, the files called simulation_* contain
the hardware setup as well. Each of them has linear model, nonlinear model
and hardware mode which can be toggled by using right-click->commment out
and uncomment


## Files of interest ##

quickstart.m
* Run this file to configure everything for all controllers
* Runs most of the other main scripts

models/EOM_script.m
* Contains the mathmetical derivation for the dynamics
* Generates MATLAB code for the nonlinear model and swingup scripts based
  on the derived physics and identified parameters
* The generated code sadly has to be copied over manually into simulink
  when changing model or parameters
    - Nonlinear simulation in for all controllers
    - Nonlinear observer
    - Swingup controller

identification/SYS_ID_spring.m
* Runs identification, can be editited to use a different identification
  dataset
* Loads estimated parameters and ss's into the workspace

observers/makeobserver.m
* Needs to be run after identication
* Configures the observer gains
* Configures LQR/LQI gains

mpc/for_demonstration.mat
* Contains MPC controller config 'mpc1'

nonlinmpc/generateinputs.m
* Generates input sequences for swingup
* Sets tuning parameters for swingup








