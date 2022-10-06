
%% Load model 

% A =    [0  0  1.0000  0; 0 0 0 1.0000; 0 58.6804 -7.1976 0.4154;0 -184.9730 7.647 -1.3094] ;
% B =   [0;0;1.1910;-1.2654]*1.0e+03 ;
% C =   [eye(2), zeros(2)] ;
% D = zeros(2,1) ;

%Ts=0.05 ;

disc_sys = ss(sys_intermediate.A,sys_intermediate.B,sys_intermediate.C,sys_intermediate.D);

test = c2d(disc_sys,Ts);


y = lsim(test,stuff.u,stuff.time);
figure
plot(stuff.time,y)
hold on 
plot(stuff.time,stuff.y,'--')
legend

%% kalman filter

P = [0,1e-1,0,0] ;
P = diag(P) ;
Q_K = [1e-1,1e-1, 1e-1,1e-1] ;
Q_K = diag(Q_K) ;
R_K = zeros(2) ;

count = length(stuff.time);

states = zeros(4,count);
states(:,1) = [0;0.1;0;0];

for i=1:(count-1)

%time update
xhat =  test.A*states(:,i) + test.B*stuff.u(i) ;
P= test.A*P*test.A' +Q_K ;

%measurement update
K = P*test.C'*inv(test.C*P*test.C' + R_K) ;

states(:,i+1)= xhat + K*(stuff.y(i+1,:)' -test.C*xhat) ;
P= P-P*test.C'*inv(test.C*P*test.C' + R_K)*test.C*P ;

xhat-states(:,i+1);
end

eig(test.A-K*test.C)
log(eig(test.A-K*test.C))/Ts


figure
plot(stuff.time,states)
legend('\alpha','\theta','dot \alpha','dot \theta')

%% LQR stuff 

Q = [1e-1 1e+2 1e-1 1e-1] ;
Q = diag(Q) ;

R = 10; 

[K,S,e]=lqr(test,Q,R);



