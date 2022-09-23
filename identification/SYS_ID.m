clc; close all; clear 

%% Loading and preparing data 
load("oldiddata/prbs_data.mat") 

global datasetname
datasetname='23sep';
stuff = loadexp('doublet') ; 

t = 0:0.02:10';
%experiment.data      

y = [stuff.alpha,stuff.theta  ] ; %output
u = stuff.u; %input
Ts = stuff.h ; %sampling time

data = iddata(y , u, Ts, 'Name', 'Qube');
data.InputName = 'Voltage';
data.InputUnit = 'V';
data.OutputName = {'alpha', 'theta'};
data.OutputUnit = {'rad', 'rad'};
data.Tstart = 0;
data.TimeUnit = 's';

plot(data)

%% Making the idgrey linear model



%parameters 
L_p = 0.12 ;%meters
L_r = 0.085 ;%meters 
m_p = 0.024 ;%kg 
m_r = 0.095 ;%kg
J_p = 1/12*m_p*L_p^2;
J_r = 1/3*m_r*L_r^2;
%J_p = 3.3e-5;
%J_r = 5.7e-5;
C_p = 0.0001 ;
C_r = 0.0015;

R_m = 8.4 ;%ohm;
K_t = 0.042 ;% Nm/A
K_m = 0.042 ;%V*s/rad

%Making the idgrey 
odefun = 'LinearQube' ;
parameters = {'Length Pendulum',L_p; 'Length Arm',L_r; 'mass pendulum', m_p; 'mass arm', m_r;...
    'pendulum inertia', J_p; 'arm inertia', J_r; 'pendulum friction coeff', C_p; 'arm friction coeff', C_r;...
     'motor Resistance',R_m; 'Torque constant', K_t; 'back EMF constant', K_m};

fcn_type ='c' ; %indiciating continuous linear function

init_sys = idgrey(odefun,parameters,fcn_type);

% specify known parameters as fixed 
% 11 params      1  , 2 , 3  , 4  , 5  ,  6 ,  7 ,  8 , 9  , 10,  11
% param order : L_p ,L_r, m_p, m_r, J_p, J_r, C_p, C_r, R_m, K_t, K_m

init_sys.Structure.Parameters(1).Free = false;
init_sys.Structure.Parameters(2).Free = false;
init_sys.Structure.Parameters(3).Free = false;
init_sys.Structure.Parameters(5).Free = false;
init_sys.Structure.Parameters(7).Free = false;
init_sys.Structure.Parameters(8).Free = false;

% specify lowerbound of params
init_sys.Structure.Parameters(4).Minimum = 0.095;
init_sys.Structure.Parameters(6).Minimum = 0;
init_sys.Structure.Parameters(7).Minimum = 0;
init_sys.Structure.Parameters(8).Minimum = 0;
init_sys.Structure.Parameters(9).Minimum = 0;
init_sys.Structure.Parameters(10).Minimum = 0;
init_sys.Structure.Parameters(11).Minimum = 0;
init_sys.Structure.Parameters(4).Maximum = 0.1;

%% Making intermediate model 

%parameters 
a11 = 0.0017;
a12 = 4.0219e-04;
a13 = 1.3158e-04;
a14 = -0.0050;

a21 = 0.0152 ;
a22 = 1.3313e-04 ;


%Making the idgrey 
odefun = 'IntermediateModel' ;
parameters = {a11;a12;a13;a14;a21;a22};

fcn_type ='c' ; %indiciating continuous linear function

init_sys_intermediate = idgrey(odefun,parameters,fcn_type);




%% Making simple model 
%parameters 
A32 = 55.15 ;
A33 = -6.283;
A42 = -168.6 ;
A43 =  6.21 ;

B3 =18.37 ;
B4 =-18.16;
%Making the idgrey 
odefun = 'SimpleModel' ;
parameters = {A32;A33;A42;A43;B3;B4};

fcn_type ='c' ; %indiciating continuous linear function

init_sys_simple = idgrey(odefun,parameters,fcn_type);

%% estimating the system

sys = greyest(data,init_sys);
opt = compareOptions('InitialCondition','zero');
figure
compare(data,sys,Inf,opt)

sys_intermediate = greyest(data,init_sys_intermediate);
figure
compare(data,sys_intermediate,Inf,opt)


sys_simple = greyest(data,init_sys_simple);
figure
compare(data,sys_simple,Inf,opt)

