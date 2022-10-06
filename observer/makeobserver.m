
h=0.01;

discrete_0=c2d(sys_0,h);

[K,S,e] = dlqr(discrete_0.A,discrete_0.B,diag([4,1,1,1]),0.01,zeros(4,1));
K

pCont=[-40,-41,-15,-16];%poles in s-domain
pDisc=exp(pCont.*h);%poles in z-domain
% cont=place(sys_0.A',sys_0.C',pCont)'
% disc=place(discrete_0.A',discrete_0.C',pDisc)'

