
h=0.005;
% to import from sys_id_spring
% sys_0=ss(sys_simple);

sys_pi=ss(sys_0.A.*[1,1,1,1;1,1,1,1;1,1,1,-1;-1,-1,-1,1],diag([1,1,1,-1])*sys_0.B,sys_0.C,sys_0.D);

discrete_0=c2d(sys_pi,h);

[K,S,e] = dlqr(discrete_0.A,discrete_0.B,diag([300,20,30,4]),0.1);
K
% K(1)=-K(1);

% poles =log(e)/h;
% pDisc = real(exp(2*poles*h));

pCont=[-40,-41,-30,-31];%poles in s-domain
pDisc=exp(pCont.*h);%poles in z-domain
% cont=place(sys_0.A',sys_0.C',pCont)'
disc=place(discrete_0.A',discrete_0.C',pDisc)'

