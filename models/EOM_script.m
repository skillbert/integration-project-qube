%% Define our parameters
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

J_p=1/12*m_p*L_p^2;

%v_r = [0 ; 0.5*L_r*alpha_dot;0]
v_r = [0;0;0];
%v_p = [0.5*L_p*sin(theta)*alpha_dot ; L_r*alpha_dot + 0.5*L_p*cos(theta)*theta_dot ; 0.5*L_p*sin(theta)*theta_dot] %a bit more complex 
v_p = [0;L_r*alpha_dot + 0.5*L_p*cos(theta)*theta_dot ; 0.5*L_p*sin(theta)*theta_dot];                             % simple version

% kinetic energy function
T_r = 1/2 * m_r*(v_r(1)^2 +v_r(2)^2+v_r(3)^2) + ...
   1/2 * J_r * alpha_dot^2;
T_p = 1/2 * m_p*(v_p(1)^2 +v_p(2)^2+v_p(3)^2) + ...
   1/2 * J_p * theta_dot^2 ;

% potential energy function
V_r = 0.5*K_wire*alpha^2;
V_p = m_p*g*(0.5*L_p)*(1-cos(theta));


% dissipation function
D= 1/2 * C_r * (alpha_dot)^2 + ...
   1/2 * C_p * (theta_dot)^2 ;

% motor torque
tau = K_t*(u -K_m*alpha_dot)/R_m;

L=T_r+T_p-V_r-V_p;



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

dD_dqdot = simplify(jacobian(D,q_dot))';

EOM=simplify(dL_dxdot_dt-dL_dx+dD_dqdot)==[tau;0];

% Obtain nonlinear state space

sol=solve(EOM,[theta_ddot,alpha_ddot],'ReturnConditions',true);
disp 'solution conditions'
pretty(sol.conditions)

nonlin=[sol.alpha_ddot;sol.theta_ddot];
%% stuff

params = {
    'Length Pendulum',L_p
    'Length Arm',L_r
    'mass pendulum', m_p
    'arm inertia', J_r
    'pendulum friction coeff', C_p
    'arm friction coeff',C_r
    'motor Resistance',R_m
    'Torque constant', K_t
    'back EMF constant', K_m
    'Wire torsion spring constant', K_wire
};
paramsym=params(:,2);

%run SYS_ID_spring to get sys
paramest=num2cell(sys.param);


%% linearaize
nonlin=subs(nonlin,{g},{9.81});
nonlin_est=subs(nonlin,paramsym,paramest);

lin_0=linearized(nonlin,q,q_dot,u,[0;0]);
lin_pi=linearized(nonlin,q,q_dot,u,[0;pi]);

funcstr=getfunctionfile(lin_0,'auto_full',params(:,2));
% writelines(funcstr,'identification/auto_full.m');


matlabFunction(nonlin_est,'Vars',{alpha;theta;alpha_dot;theta_dot;u}','File','models/generated_nonlinfit','Outputs',{'x_ddot'});


sys_0=ss(double(subs(lin_0.A,paramsym,paramest)),double(subs(lin_0.B,paramsym,paramest)),double(subs(lin_0.C,paramsym,paramest)),double(subs(lin_0.D,paramsym,paramest)));
sys_pi=ss(double(subs(lin_pi.A,paramsym,paramest)),double(subs(lin_pi.B,paramsym,paramest)),double(subs(lin_pi.C,paramsym,paramest)),double(subs(lin_pi.D,paramsym,paramest)));



% E=1/2*J_p*theta_dot^2-cos(theta)*m_p*g*(1/2*L_p);
% E=-cos(theta)*m_p*g*(1/2*L_p);
E=V_p+T_p;


syms step real
alpha_ddot_next=nonlin(1);
theta_ddot_next=nonlin(2);
alpha_dot_next=alpha_dot+alpha_ddot_next*step;
theta_dot_next=theta_dot+theta_ddot_next*step;
alpha_next=alpha_dot_next*step;
theta_next=theta_dot_next*step;

% pretty(subs(subs(subs(E,paramsym,paramest),{alpha,theta,alpha_dot,theta_dot},{alpha+alpha_dot+alpha_ddot,theta+theta_dot+theta_ddot,alpha_dot+alpha_ddot,theta_dot+theta_ddot}),{alpha_ddot}));
%change of energy for input u
dEdtu=simplify(jacobian(E,[alpha_dot,theta_dot])*diff(nonlin,u));


energy=subs(dEdtu,paramsym,paramest);

denergy=subs(E,{alpha,theta,alpha_dot,theta_dot},{alpha_next,theta_next,alpha_dot_next,theta_dot_next})-E;
denergy_posu=subs(subs(denergy,paramsym,paramest),{alpha,g,step,alpha_dot,u},{0,9.81,0.1,0,0.2});
denergy_negu=subs(subs(denergy,paramsym,paramest),{alpha,g,step,alpha_dot,u},{0,9.81,0.1,0,-0.2});

figure(1);
fsurf(denergy_posu);
figure(2);
fsurf(denergy_negu);


