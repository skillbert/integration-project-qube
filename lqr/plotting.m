

% [K,S,e] = dlqr(discrete_0.A,discrete_0.B,diag([20,5,1,1]),0.1);
% KK=ss([],[],[],K,h);
% fs=ss(discrete_0.A,discrete_0.B,eye(4),[],h);
% cl = feedback(fs,KK) ;
% testing = ss(discrete_0.A- discrete_0.B*K,discrete_0.B,[eye(2),zeros(2)],[],h);
% constgain=ones(1,4)./dcgain(cl)';
% constgain(2:4)=1;
% clnew = ss(discrete_0.A- discrete_0.B*K, discrete_0.B*constgain(1),[eye(2),zeros(2)],[],h );
% 
% [y,~,x]=lsim(clnew,simin(:,2));
% realu = -K*x' + simin(:,2)'*constgain(1);
%Q = [20,5,1,1];

Q1 = [10,1,1,1];
%Q1 = [20,5,1,1];
R1 = 1;

Q2 = [1,10,1,1];
R2 = 1;

Q3 = [1,1,10,1];
R3 = 1;

Q4 = [1,1,1,10] ;
R4 = 1 ;

Qfinal = [25,1,1,1];
Rfinal = 1; 

data1 = getLQRstats(discrete_0,h,simin,Q1,R1);
data2 = getLQRstats(discrete_0,h,simin,Q2,R2);
data3 = getLQRstats(discrete_0,h,simin,Q3,R3);
data4 = getLQRstats(discrete_0,h,simin,Q4,R4);
data5 = getLQRstats(discrete_0,h,simin,Qfinal,Rfinal);

figure
title('')
subplot(3,1,1)
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