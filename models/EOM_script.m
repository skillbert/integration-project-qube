%% Define our parameters
syms J_r real positive;%moment of inertia of arm around pivot
syms J_p real positive;%moment of inertia of around center of mass
syms M_p real positive;%mass of pendulum
syms L_r real positive;%length of arm
syms L_pcom real positive;%position of center of mass of pendulum

syms g real positive;%gravity constant

% generalized coordinates
syms alpha real;%angle of arm
syms theta real;%angle of pendulum, 0=down
syms F real;%torque on arm
syms alpha_dot alpha_ddot real;
syms theta_dot theta_ddot real;

q=[alpha;theta];
q_dot=[alpha_dot;theta_dot];
q_ddot=[alpha_ddot;theta_ddot];

% lagrangian
T_r = 1/2*J_r*alpha_dot^2; % rotation of arm mass
T_p = 1/2*J_p*theta_dot^2 ... % rotation of pendulum itself
    + 1/2*M_p*(alpha_dot*L_r+theta_dot*L_pcom*cos(theta))^2 ... % movement around arm pivot
    + 1/2*M_p*(L_pcom*sin(theta))^2;
% ignoring moment of inertia of pendulum rotating around pivot for now
% also ignoring the center of mass of pendulum moving further away from
%   pivot when theta changes

% D= 1/2 * C_r * (alpha_dot)^2 + ...
%    1/2 * C_p * (theta_dot)^2 ;
V_p = -cos(theta)*L_pcom*M_p*g;

L=T_r+T_p+-V_p;

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

EOM=simplify(dL_dxdot_dt-dL_dx);

% Obtain nonlinear state space

sol=solve(EOM==[F;0],[theta_ddot,alpha_ddot],'ReturnConditions',true);
disp 'solution conditions'
pretty(sol.conditions)

nonlin=[sol.alpha_ddot;sol.theta_ddot];

%% linearaize
% Inital estimate
syms M_r L_p
estimates=solve([
    M_r==0.02
    L_p==0.075
    
    J_r==1/6*L_r*M_r
    J_p==1/12*L_p*M_p
    M_p==0.03
    L_r==0.06
    L_pcom==L_p/2
    g==9.81
]);

estimatesubs=[
    J_r,estimates.J_r
    J_p,estimates.J_p
    M_p,estimates.M_p
    L_r,estimates.L_r
    L_pcom,estimates.L_pcom
    g,estimates.g
];

nonlin_est=subs(nonlin,estimatesubs(:,1),estimatesubs(:,2));

lin_0=linearized(nonlin,q,q_dot,F,[0;0]);
lin_pi=linearized(nonlin,q,q_dot,F,[0;pi]);

bgain=0.0001;

sys0=ss(lin_0.A,lin_0.B,lin_0.C,lin_0.D);





















