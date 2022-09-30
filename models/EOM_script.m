%% Define our parameters
clc;clear;
syms J_r real positive;%moment of inertia of arm around pivot
syms J_p real positive;%moment of inertia of around center of mass
syms m_p real positive;%mass of pendulum
syms m_r real positive;%mass of arm
syms L_r real positive;%length of arm
syms L_p real positive;%length of pendulum
syms L_pcom real positive;%position of center of mass of pendulum
syms C_r C_p real positive;%damping constants
syms K_t K_m R_m real %motor constants
syms K_wire real positive % spring constant because of the wire

syms g real positive;%gravity constant

% generalized coordinates
syms alpha real;%angle of arm
syms theta real;%angle of pendulum, 0=down
syms u real;%input signal
syms alpha_dot alpha_ddot real;
syms theta_dot theta_ddot real;

q=[alpha;theta];
q_dot=[alpha_dot;theta_dot];
q_ddot=[alpha_ddot;theta_ddot];

% % lagrangian
% T_r = 1/2*J_r*alpha_dot^2; % rotation of arm mass
% T_p = 1/2*J_p*theta_dot^2 ... % rotation of pendulum itself
%     + 1/2*M_p*(alpha_dot*L_r+theta_dot*L_pcom*cos(theta))^2 ... % movement around arm pivot
%     + 1/2*M_p*(L_pcom*sin(theta))^2;
% % ignoring moment of inertia of pendulum rotating around pivot for now
% % also ignoring the center of mass of pendulum moving further away from
% %   pivot when theta changes
% 
% % D= 1/2 * C_r * (alpha_dot)^2 + ...
% %    1/2 * C_p * (theta_dot)^2 ;
% V_p = -cos(theta)*L_pcom*M_p*g;
% 
% % dissipation function
% D= 1/2 * C_r * (alpha_dot)^2 + ...
%    1/2 * C_p * (theta_dot)^2 ;
% speed components of the masses

%v_r = [0 ; 0.5*L_r*alpha_dot;0]
v_r = [0;0;0];
%v_p = [0.5*L_p*sin(theta)*alpha_dot ; L_r*alpha_dot + 0.5*L_p*cos(theta)*theta_dot ; 0.5*L_p*sin(theta)*theta_dot] %a bit more complex 
v_p = [0;L_r*alpha_dot + 0.5*L_p*cos(theta)*theta_dot ; 0.5*L_p*sin(theta)*theta_dot];                             % simple version

% kinetic energy function
T =1/2 * m_r*(v_r(1)^2 +v_r(2)^2+v_r(3)^2) + ...
   1/2 * m_p*(v_p(1)^2 +v_p(2)^2+v_p(3)^2) + ...
   1/2 * J_r * alpha_dot^2 + ...
   1/2 * J_p * theta_dot^2 ;

% potential energy function
V = 0.5*m_r*g*L_p*(1-cos(theta)) ...
    + 0.5*K_wire*alpha^2;


% dissipation function
D= 1/2 * C_r * (alpha_dot)^2 + ...
   1/2 * C_p * (theta_dot)^2 ;

% motor torque
tau = K_t*(u -K_m*alpha_dot)/R_m;

L=T-V;



%% equations of motion

dL_dxdot=simplify([
    diff(L,alpha_dot)
    diff(L,theta_dot)
]);

dL_dxdot_dt=jacobian(dL_dxdot,[alpha,alpha_dot,theta,theta_dot])...
    *[alpha_dot,alpha_ddot,theta_dot,theta_ddot]';

dL_dx=simplify([
    diff(L,alpha)
    diff(L,theta)
]);

dD_dqdot =  simplify(jacobian(D,q_dot))';

EOM=simplify(dL_dxdot_dt-dL_dx+dD_dqdot)==[tau;0];

% Obtain nonlinear state space

sol=solve(EOM,[theta_ddot,alpha_ddot],'ReturnConditions',true);
disp 'solution conditions'
pretty(sol.conditions)

nonlin=[sol.alpha_ddot;sol.theta_ddot];
%% stuff

params={'Length Pendulum',L_p; 'Length Arm',L_r; 'mass pendulum', m_p; 'mass arm', m_r;...
    'pendulum inertia', J_p; 'arm inertia', J_r; 'pendulum friction coeff', C_p; 'arm friction coeff', C_r;...
     'motor Resistance',R_m; 'Torque constant', K_t; 'back EMF constant', K_m;'gravity constant',g;'wire spring constant',K_wire};




%% linearaize
% Inital estimate
% 
% L_p = 0.129; %meters
% L_r = 0.085; %meters 
% m_p = 0.024; %kg 
% m_r = 0.095; %kg
% J_p = 1/12*m_p*L_p^2;
% J_r = 1/3*m_r*L_r^2;
% %J_p = 3.3e-5;
% %J_r = 5.7e-5;
% C_p = 0.0005;
% C_r = 0.0015;
% K_wire = 0;%nm/rad
% 
% R_m = 8.4; %ohm
% K_t = 0.042; % Nm/A
% K_m = 0.042; %Vs/rad
% 
% g = 9.81;

L_p = 0.12; %meters
L_r = 0.085; %meters 
m_p = 0.024; %kg 
m_r = 0.095; %kg
J_p = 2.88e-05;
J_r = 0.000142;
%J_p = 3.3e-5;
%J_r = 5.7e-5;
C_p = 0.0001;
C_r = 0.0015;
K_wire = 0;%nm/rad

R_m = 8.4; %ohm
K_t = 2.168; % Nm/A
K_m = 0.006544; %Vs/rad

g = 9.81;


nonlin_est=subs(nonlin);

lin_0=linearized(nonlin,q,q_dot,u,[0;0]);
lin_pi=linearized(nonlin,q,q_dot,u,[0;pi]);

bgain=0.0001;

funcstr=getfunctionfile(lin_0,'auto_full',params(:,2));
writelines(funcstr,'identification/auto_full.m');


matlabFunction(nonlin_est,'Vars',{alpha;theta;alpha_dot;theta_dot;u}')


sys_0=ss(double(subs(lin_0.A)),double(subs(lin_0.B)),double(subs(lin_0.C)),double(subs(lin_0.D)));



h=0.01;
discrete_0=c2d(sys_0,h);

[K,S,e] = dlqr(discrete_0.A,discrete_0.B,eye(1),1,zeros(4,1));














