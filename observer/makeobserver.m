
h=0.005;
% to import from sys_id_spring
sys_0=ss(sys_simple);

sys_pi=ss(sys_0.A.*[1,1,1,1;1,1,1,1;1,1,1,-1;-1,-1,-1,1],diag([1,1,1,-1])*sys_0.B,sys_0.C,sys_0.D);

sys_eq=sys_pi;

discrete_eq=c2d(sys_eq,h);

[K,S,e] = dlqr(discrete_eq.A,discrete_eq.B,diag([20,5,1,1]),0.1);
K;

poles =log(e)/h;
% pDisc = real(exp(2*poles*h));
% pDisc(4)=0.5;

pCont=[-80,-81,-60,-61];%poles in s-domain
pDisc=exp(pCont.*h);%poles in z-domain
% cont=place(sys_0.A',sys_0.C',pCont)'
disc=place(discrete_eq.A',discrete_eq.C',pDisc)'


KK=ss([],[],[],K,h);
fs=ss(discrete_eq.A,discrete_eq.B,eye(4),[],h);
constgain=ones(1,4)./dcgain(feedback(fs,KK))';
constgain(2:4)=0;

% simin = simin(:,1:3);
% K = [K,0.4,0];

