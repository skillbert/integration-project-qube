% [K,S,e] = dlqr(discrete_0.A,discrete_0.B,diag([20,5,1,1]),0.1);
% KK=ss([],[],[],K,h);
% fs=ss(discrete_0.A,discrete_0.B,eye(4),[],h);
% cl = feedback(fs,KK) ;
% testing = ss(discrete_0.A- discrete_0.B*K,discrete_0.B,[eye(2),zeros(2)],[],h);
% constgain=ones(1,4)./dcgain(cl)';
% constgain(2:4)=0;
% clnew = ss(discrete_0.A- discrete_0.B*K, discrete_0.B.*constgain',[eye(2),zeros(2)],[],h );
% figure
% step(clnew)

%sim simulation_lqr_for_latex
[sizea,sizeb,sizec]=size(simout.Data);
input = reshape(simout.Data(1,1,:),[1,sizec]) ;
output= reshape(simout.Data(2:3,1,:),[2,sizec]);

figure
subplot(1,2,1)
plot(timesraw,input);
legend('input')
xlabel('time [s]')
ylabel('input Voltage [V]')

subplot(1,2,2)
plot(timesraw,output)
legend('\alpha','\theta')
xlabel('time [s]')
ylabel('angle [rad]')