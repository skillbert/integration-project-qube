
%% loading the data
datasetname='21_oct_ref';


%% plotting 
discrete_0=discrete_eq ;
Q1 = [10,1,1,1];
%Q1 = [20,5,1,1];
R1 = 1;

Q2 = [1,10,1,1];
R2 = 1;

Q3 = [1,1,10,1];
R3 = 1;

Q4 = [1,1,1,10] ;
R4 = 1 ;

Qfinal = [30,1,1,1];
Rfinal = 1; 

data1 = getLQRstats(discrete_0,h,simin,Q1,R1);
data2 = getLQRstats(discrete_0,h,simin,Q2,R2);
data3 = getLQRstats(discrete_0,h,simin,Q3,R3);
data4 = getLQRstats(discrete_0,h,simin,Q4,R4);
data5 = getLQRstats(discrete_0,h,simin,Qfinal,Rfinal);

figure
subplot(3,1,1)
title('Step response with different weights')
hold on
plot(timesraw,data1(:,1))
plot(timesraw,data2(:,1))
plot(timesraw,data3(:,1))
plot(timesraw,data4(:,1))
plot(timesraw,data5(:,1))
legend('Q1=[10,1,1,1]','Q2 = [1,10,1,1]','Q3 = [1,1,10,1]','Q4 = [1,1,1,10]','Qfinal = [30,1,1,1]')
xlabel('time [s]')
ylabel('input Voltage [V]')

subplot(3,1,2) 
hold on
plot(timesraw,data1(:,2))
plot(timesraw,data2(:,2))
plot(timesraw,data3(:,2))
plot(timesraw,data4(:,2))
plot(timesraw,data5(:,2))
%legend('\alpha','\theta')
xlabel('time [s]')
ylabel('\alpha angle [rad]')

subplot(3,1,3)
hold on
plot(timesraw,data1(:,3))
plot(timesraw,data2(:,3))
plot(timesraw,data3(:,3))
plot(timesraw,data4(:,3))
plot(timesraw,data5(:,3))
%legend('\alpha','\theta')
xlabel('time [s]')
ylabel('\theta angle [rad]')

%% plot the real data 
nonlin_stepdata = loadexp('nonlin_refstep') ;
real_stepdata = loadexp('real_refstep') ;
lin_stepdata = loadexp('linear_refstep') ;

figure
subplot(3,1,1)
title('Step response on different models')
hold on
%plot(timesraw,data5(:,1))
plot(timesraw,lin_stepdata.u)
plot(timesraw,nonlin_stepdata.u)
plot(timesraw,real_stepdata.u)
legend('linear-model','non-linear-model','real model')
xlabel('time [s]')
ylabel('input Voltage [V]')
xlim([4 9])

subplot(3,1,2) 
hold on
%plot(timesraw,data5(:,2))
plot(timesraw,lin_stepdata.y(:,1))
plot(timesraw,nonlin_stepdata.y(:,1))
plot(timesraw,real_stepdata.y(:,1))
%legend('\alpha','\theta')
xlabel('time [s]')
ylabel('\alpha angle [rad]')
xlim([4 9])

subplot(3,1,3)
hold on
%plot(timesraw,data5(:,3))
plot(timesraw,lin_stepdata.y(:,2))
plot(timesraw,nonlin_stepdata.y(:,2))
plot(timesraw,real_stepdata.y(:,2))
%legend('\alpha','\theta')
xlabel('time [s]')
ylabel('\theta angle [rad]')
xlim([4 9])


%% plotting LQI 
datasetname = '21_oct_LQI';
LQIdata02 = loadexp('LQI_0_2') ;
LQIdata04 = loadexp('LQI_0_4') ;
LQIdata05 = loadexp('LQI_0_5') ;
LQIdata06 = loadexp('LQI_0_6') ;
LQIdata08 = loadexp('LQI_0_8') ;

figure
subplot(2,1,1) 
hold on
plot(timesraw,real_stepdata.y(:,1))
plot(timesraw,LQIdata02.y(:,1))
plot(timesraw,LQIdata04.y(:,1))
plot(timesraw,LQIdata05.y(:,1))
plot(timesraw,LQIdata06.y(:,1))
plot(timesraw,LQIdata08.y(:,1))
%legend('\alpha','\theta')
xlabel('time [s]')
ylabel('\alpha angle [rad]')
xlim([4 13])
title('LQR vs LQI with different K_e')
legend('LQR','LQI Ke = 0.2','LQI Ke = 0.4','LQI Ke = 0.5','LQI Ke = 0.6','LQI Ke = 0.8')

subplot(2,1,2)
hold on
plot(timesraw,real_stepdata.y(:,2))
plot(timesraw,LQIdata02.y(:,2))
plot(timesraw,LQIdata04.y(:,2))
plot(timesraw,LQIdata05.y(:,2))
plot(timesraw,LQIdata06.y(:,2))
plot(timesraw,LQIdata08.y(:,2))
%legend('\alpha','\theta')
xlabel('time [s]')
ylabel('\theta angle [rad]')
xlim([4 13])

%% response time for MPC

clsystem = getsys(discrete_0,h,simin,Qfinal,Rfinal);
S = stepinfo(clsystem);

%%

% sim simulation_lqr_for_latex
% [sizea,sizeb,sizec]=size(simout.Data);
% input = reshape(simout.Data(1,1,:),[1,sizec]) ;
% output= reshape(simout.Data(2:3,1,:),[2,sizec]);
% 
% figure
% subplot(1,2,1)
% plot(timesraw,input);
% legend('input')
% xlabel('time [s]')
% ylabel('input Voltage [V]')
% 
% subplot(1,2,2)
% plot(timesraw,output)
% legend('\alpha','\theta')
% xlabel('time [s]')
% ylabel('angle [rad]')


function data = getLQRstats(discrete_0,h,simin,Q,R)
[K,S,e] = dlqr(discrete_0.A,discrete_0.B,diag(Q),R);
KK=ss([],[],[],K,h);
fs=ss(discrete_0.A,discrete_0.B,eye(4),[],h);
cl = feedback(fs,KK) ;
%testing = ss(discrete_0.A- discrete_0.B*K,discrete_0.B,[eye(2),zeros(2)],[],h);
constgain=ones(1,4)./dcgain(cl)';
clnew = ss(discrete_0.A- discrete_0.B*K, discrete_0.B*constgain(1),[eye(2),zeros(2)],[],h );

[y,~,x]=lsim(clnew,simin(:,2));
realu = -K*x' + simin(:,2)'*constgain(1);

data = [realu', y, x];

end

function sys = getsys(discrete_0,h,simin,Q,R)
[K,S,e] = dlqr(discrete_0.A,discrete_0.B,diag(Q),R);
KK=ss([],[],[],K,h);
fs=ss(discrete_0.A,discrete_0.B,eye(4),[],h);
cl = feedback(fs,KK) ;
%testing = ss(discrete_0.A- discrete_0.B*K,discrete_0.B,[eye(2),zeros(2)],[],h);
constgain=ones(1,4)./dcgain(cl)';
clnew = ss(discrete_0.A- discrete_0.B*K, discrete_0.B*constgain(1),[eye(2),zeros(2)],[],h );
sys = clnew;
end
