clc; clear all; close all 

global datasetname
datasetname='30sep';
stuff = loadexp('thetaonly') ; 

%L_p = 0.12 ;
L_p = 0.123;
g = 9.81 ;
m_p = 0.024 ;
J_p = 1/3*m_p*L_p^2;
%C_p = 0.001 ;
%C_p = 0.00001;
C_p = 0.000012 ;

A = [0 1; -0.5*m_p*g*L_p/J_p -C_p/J_p] ;

B =[0;0] ;

C = [1 0] ;
D = 0 ;

x0 = [0.3;0] ; 

sys = ss(A,B,C,D) ;

t= 1.33:0.01:20;
u = zeros(size(t));
y =lsim(sys,u,t,x0) ;

figure
plot(stuff.time(133:end),stuff.theta(133:end))
title('Pendulum only experiment')
xlabel('time [s]')
ylabel('\theta angle [radians]')

 figure
 plot(t,y,'--',stuff.time(133:end),stuff.theta(133:end))
 legend('simulation','real pendulum')
 title('Pendulum only experiment')
 xlabel('time [s]')
 ylabel('\theta angle [radians]')


