function [A,B,C,D] = LinearQube(L_p ,L_r, m_p, m_r, J_p, J_r, C_p, C_r, R_m, K_t, K_m,Ts)

% L_p = Length of pendulum in [meters]
% L_r = Length of arm in [meters]
% m_p = mass of pendulum in [kg]
% m_r = mass of arm in [kg]
% J_p = Moment of inertia pendulum in [kg*m^2]
% J_r = Moment of inertia arm in [kg*m^2]

% C_p = friction coefficient of pendulum in [N*m*s/rad]
% C_r = friction coefficient of arm in [N*m*s/rad]
% 
% R_m = Motor resistance in [Ohm]
% K_t = Torque constant in [N*m/A]
% K_m = Motor back EMF constant in [V*s/rad]

g = 9.81 ; % gravity [m/s^2]


                                                                                                                                                                                   
A1 = [0,            (L_p^2*L_r*g*m_p^2)/(4*(((m_p*L_p^2)/4 + J_p)*(m_p*L_r^2 + J_r) - (L_p^2*L_r^2*m_p^2)/4)), -(((m_p*L_p^2)/4 + J_p)*(C_r + (K_m*K_t)/R_m))/(((m_p*L_p^2)/4 + J_p)*(m_p*L_r^2 + J_r) - (L_p^2*L_r^2*m_p^2)/4),    (C_p*L_p*L_r*m_p)/(2*(((m_p*L_p^2)/4 + J_p)*(m_p*L_r^2 + J_r) - (L_p^2*L_r^2*m_p^2)/4))];
A2 = [0, -(L_p*g*m_p*(m_p*L_r^2 + J_r))/(2*(((m_p*L_p^2)/4 + J_p)*(m_p*L_r^2 + J_r) - (L_p^2*L_r^2*m_p^2)/4)),        (L_p*L_r*m_p*(C_r + (K_m*K_t)/R_m))/(2*(((m_p*L_p^2)/4 + J_p)*(m_p*L_r^2 + J_r) - (L_p^2*L_r^2*m_p^2)/4)), -(C_p*(m_p*L_r^2 + J_r))/(((m_p*L_p^2)/4 + J_p)*(m_p*L_r^2 + J_r) - (L_p^2*L_r^2*m_p^2)/4)];

B1 = (K_t*((m_p*L_p^2)/4 + J_p))/(R_m*(((m_p*L_p^2)/4 + J_p)*(m_p*L_r^2 + J_r) - (L_p^2*L_r^2*m_p^2)/4));
B2 = -(K_t*L_p*L_r*m_p)/(2*R_m*(((m_p*L_p^2)/4 + J_p)*(m_p*L_r^2 + J_r) - (L_p^2*L_r^2*m_p^2)/4));


A = [0 0 1 0; 0 0 0 1; A1; A2];
B = [0;0;B1;B2];
C = [1, 0, 0, 0; 0, 1, 0, 0] ;
D = zeros(2,1);

end 