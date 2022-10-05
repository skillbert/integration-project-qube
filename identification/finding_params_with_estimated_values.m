%clear all; close all;

%% Finding intermediate sys parameters

syms m_r m_p                 real positive    %mass of the parts
syms J_r J_p                 real positive    %moment of inertia J_r is moment of In. around its end, J_p = moment of In around its COM
syms C_r C_p                 real positive    %damping constants
syms L_r L_p                 real positive    %lengths
syms g                      real positive     %gravity
syms K_t u K_m R_m         real positive %motor constants

g = 9.81 ;

a11 = (C_r + (K_m*K_t)/R_m);
a12 = (m_p*L_r^2 + J_r) ;
a13 = ((L_p*L_r*m_p)/2);
a14 = (-K_t/R_m) ;

a21 = ((L_p*g*m_p)/2);
J_p = 1/12*m_p*L_p^2;
a22 = ((m_p*L_p^2)/4 + J_p);


   Par1 = 0.0009025;
   Par2 = 0.0002386;
   Par3 = 0.0001095;
   Par4 = -0.1862;
   Par5 = 0.01346;
   Par6 = 0.0001047;

   eq = [a11;a12;a13;a14;a21;a22]==[Par1;Par2;Par3;Par4;Par5;Par6];
   
% params=solve(eq,[L_p,L_r,J_r,C_r,K_t,K_m,R_m]);

params1=solve(eq([5,6,2,3]),[L_p,m_p,L_r,J_r]);
L_p = double(params1.L_p) ;
L_r = double(params1.L_r) ;
m_p = double(params1.m_p) ;
J_r = double(params1.J_r) ;


params2=solve(eq([1,4]),[R_m,K_t,C_r]);
K_m = 0.042 ;
params2=subs(params2);

R_m = double(params2.R_m) ;
K_t = double(params2.K_t) ;
C_r = double(params2.C_r) ;

