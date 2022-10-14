
h=0.005;
% to import from sys_id_spring
sys_0=ss(sys_simple);

sys_pi=ss(sys_0.A.*[1,1,1,1;1,1,1,1;1,1,1,-1;-1,-1,-1,1],diag([1,1,1,-1])*sys_0.B,sys_0.C,sys_0.D);

discrete_0=c2d(sys_pi,h);

[K,S,e] = dlqr(discrete_0.A,discrete_0.B,diag([20,5,1,1]),0.1);
K 
% K(1)=-K(1);

% poles =log(e)/h;
% pDisc = real(exp(2*poles*h));
% pDisc(4)=0.5;

pCont=[-80,-81,-60,-61];%poles in s-domain
pDisc=exp(pCont.*h);%poles in z-domain
% cont=place(sys_0.A',sys_0.C',pCont)'
disc=place(discrete_0.A',discrete_0.C',pDisc)'

KK=ss([],[],[],K,h);
fs=ss(discrete_0.A,discrete_0.B,eye(4),[],h);
constgain=ones(1,4)./dcgain(feedback(fs,KK))';
constgain(2:4)=0;

simin = simin(:,1:3);
K = [K,0.4,0];

