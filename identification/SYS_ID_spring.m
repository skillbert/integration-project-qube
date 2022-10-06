clc; close all; clear 

%% Loading and preparing data 
% run fixpath in root folder first
%29sep_loweru
global datasetname
%datasetname='29sep_loweru';
datasetname='6oct';
stuff = loadexp('prbs') ; 
%datasetname='30sep';
%datasetname='29sep_loweru';
validation_stuff= loadexp('sweep') ;


%experiment.data      

starttime = stuff.h; %seconds   set stuff.h for starting at 0
startingnumber = floor(starttime / stuff.h) ;

y = [detrend(stuff.alpha(2:end),1),stuff.theta(2:end) ] ; %output
u = stuff.u(startingnumber:end-1); %input
Ts = stuff.h ; %sampling time

%data preprocessing?


data = iddata(y , u, Ts, 'Name', 'Qube');
data.InputName = 'Voltage';
data.InputUnit = 'V';
data.OutputName = {'alpha', 'theta'};
data.OutputUnit = {'rad', 'rad'};
data.Tstart = 0;
data.TimeUnit = 's';

plot(data)




%% validation data 
validation_data = iddata([validation_stuff.alpha(2:end), validation_stuff.theta(2:end)],validation_stuff.u(1:end-1), validation_stuff.h, 'Name', 'Validation data');
data.InputName = 'Voltage';
data.InputUnit = 'V';
data.OutputName = {'alpha', 'theta'};
data.OutputUnit = {'rad', 'rad'};
data.Tstart = 0;
data.TimeUnit = 's';

figure
plot(validation_data)

% %% plotting different inputs for overleaf
% 
% next_stuff= loadexp('doublet');
% 
% figure
% subplot(1,3,1)
% plot(stuff.time,stuff.u)
% xlabel('time [s]')
% ylabel('Voltage [V]')
% title('PRBS')
% 
% subplot(1,3,2)
% plot(validation_stuff.time,validation_stuff.u)
% xlabel('time [s]')
% title('Frequency sweep')
% 
% subplot(1,3,3)
% plot(next_stuff.time,next_stuff.u)
% xlabel('time [s]')
% title('Doublet')
% 
% trend = validation_stuff.time*-0.002;
% figure
% plot(validation_stuff.time,validation_stuff.alpha,validation_stuff.time,trend,'--')
% legend('\alpha raw data','trend')
% xlabel('time [s]')
% ylabel('\alpha [rad]')
% title('Frequency sweep \alpha angle')


%% Making the idgrey linear model



%parameters L_r \\
L_p = 0.123 ;%meters
L_r = 0.085 ;%meters 
m_p = 0.024 ;%kg 
m_r = 0.095 ;%kg  %doesn't get used 
J_p = 1/12*m_p*L_p^2;
J_r = 1/3*m_r*L_r^2;
C_p = 0.000012 ;
%C_p = 0;
C_r = 0.0015;

R_m = 8.4 ;%ohm;
K_t = 0.042 ;% Nm/A
K_m = 0.042 ;%V*s/rad
K_wire = 0.01 ;%Nm/rad

% new test

% L_p = 0.1145 ;%meters
% L_r = 0.0798 ;%meters 
% m_p = 0.024 ;%kg 
% J_p = 1/12*m_p*L_p^2;
% J_r = 8.5907e-05;
% C_p = 0;
% C_r = -0.0069;
% 
% 
% R_m = 5.3706 ;%ohm;
% K_t = 1 ;% Nm/A
% K_m = 0.042 ;%V*s/rad
% K_wire = 0.01 ;%Nm/rad

%Making the idgrey 
odefun = 'LinearQube_spring' ;
parameters = {'Length Pendulum',L_p; 'Length Arm',L_r; 'mass pendulum', m_p;...
     'arm inertia', J_r; 'pendulum friction coeff', C_p; 'arm friction coeff', C_r;...
     'motor Resistance',R_m; 'Torque constant', K_t; 'back EMF constant', K_m; 'Wire torsion spring constant', K_wire};

fcn_type ='c' ; %indiciating continuous linear function

init_sys = idgrey(odefun,parameters,fcn_type);

% specify known parameters as fixed 
% 11 params      1  , 2 , 3  , 4  , 5  ,  6 ,  7 ,  8 , 9  , 10,  
% param order : L_p ,L_r, m_p, J_r, C_p, C_r, R_m, K_t, K_m, K_wire

init_sys.Structure.Parameters(1).Free = false;
init_sys.Structure.Parameters(2).Free = false;
init_sys.Structure.Parameters(3).Free = false;
% init_sys.Structure.Parameters(4).Free = false;
init_sys.Structure.Parameters(5).Free = false;
% init_sys.Structure.Parameters(7).Free = false;
% init_sys.Structure.Parameters(8).Free = false;
% init_sys.Structure.Parameters(9).Free = false;
% init_sys.Structure.Parameters(10).Free = false;

% specify lowerbound of params
% init_sys.Structure.Parameters(4).Minimum = 0.05;
% %init_sys.Structure.Parameters(6).Minimum = 0;
% init_sys.Structure.Parameters(7).Minimum = 0;
% init_sys.Structure.Parameters(8).Minimum = 0;
% init_sys.Structure.Parameters(9).Minimum = 0;
% init_sys.Structure.Parameters(10).Minimum = 0;



%% Making intermediate model 

%parameters 
g= 9.81;

a11 = (C_r + (K_m*K_t)/R_m);
a12 = (m_p*L_r^2 + J_r) ;
a13 = ((L_p*L_r*m_p)/2);
a14 = (-K_t/R_m) ;

a21 = ((L_p*g*m_p)/2);
a22 = ((m_p*L_p^2)/4 + J_p);


%Making the idgrey 
odefun = 'IntermediateModel_spring' ;
parameters = {a11;a12;a13;a14;a21;a22};

fcn_type ='c' ; %indiciating continuous linear function

init_sys_intermediate = idgrey(odefun,parameters,fcn_type);




%% Making simple model 
%parameters 
A31 = -36.7456 ;
A32 = 55.1525 ;
A33 = -6.2835;
A41 = 36.3183; 
A42 = -168.6 ;
A43 =  6.21 ;

B3 =18.37 ;
B4 =-18.16;
%Making the idgrey 
odefun = 'SimpleModel_spring' ;
parameters = {A31;A32;A33;A41;A42;A43;B3;B4};

fcn_type ='c' ; %indiciating continuous linear function

init_sys_simple = idgrey(odefun,parameters,fcn_type);

%% estimating the system

% complex model
sys = greyest(data,init_sys);
opt = compareOptions('InitialCondition','zero');
figure
compare(data,sys,Inf,opt)

figure
compare(validation_data,sys,Inf,opt)

% intermediate model
sys_intermediate = greyest(data,init_sys_intermediate);
figure
compare(data,sys_intermediate,Inf,opt)

figure
compare(validation_data,sys_intermediate,Inf,opt)

% simple model
sys_simple = greyest(data,init_sys_simple);
figure
compare(data,sys_simple,Inf,opt)

figure
compare(validation_data,sys_simple,Inf,opt)
