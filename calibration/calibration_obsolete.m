clear;clc;close all;

%% hwinit 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Crane: RT blocks paramaters, I/O conversions
% Adapted on 20-01-2011 by Mernout Burger
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Values for the angle sensors, and the joystick input
%                       [angle  -angle  joy_y   joy_x]
adinchannels =          [ 1      2       3       4    ]; % input channel
adinoffs =              [ 0.011  0.075  -0.013   0.005]; % input offset for angle and joystick 
adingain =              [-0.851 -0.851   1       1    ]; % input gain (machine units -> degree) 

% Values for the hoist and trolley sensors
%                       [trolley hoist   ]
adinchannelsencoders =  [ 1       2      ];              % encoder output[hoist trolley ]
adinoffsencoders =      [ 0       0      ];              % input offset for encoder inputs
adingainencoders =      [-4.5e-6  2.35e-5];              % input gain (machine units -> meters) [trolley hoist]


% no change
dinchannels = [17:19];                                   % input channel [left right top]

daoutchannels = [1 2];                                   % output channel [trolley hoist]
daoutoffs = [-1e-4 -2e-3];                               % output offset  [trolley hoist]
daoutgain = [0.8 2.5];                                   % output gain    [trolley hoist]

ticklost = 100;                                          % max number of ticks lost




%% calibrate values

%sim details 
h = 0.01  ;% sampling time
T= 0 ;
time = 0:h:T ;
sim qubetemplate

%
y = [alphasim.data , thetasim.data];
%
save('calibrate_alpha.mat','y')
figure


%% linear regression 

% y = a(x-b) / y= ax+b, y=real value, x= sensor value, b=bias

radians_alpha = [3/4 0.5 1/4 0 -1/4 -0.5 -3/4]'*pi ; %real values
alpha_sensor_angles = [2.37 1.56 0.79 0 -0.73 -1.53 -2.38]' ; % fill it in from sensor

X= [ones(size(radians_alpha)),alpha_sensor_angles];
b_alpha = X\radians_alpha ;

figure

radians_theta = [] ; %
theta_sensor_angles = []



































