h=0.005;
% to import from sys_id_spring
sys_0 = ss(sys) ;

sys_pi=ss(sys_0.A.*[1,1,1,1;1,1,1,1;1,1,1,-1;-1,-1,-1,1],diag([1,1,1,-1])*sys_0.B,sys_0.C,sys_0.D);

sys_for_mpc = ss(sys_pi.A,sys_pi.B,eye(4),[],'StateName',{'\alpha [rad]' '\theta [rad]','\dot{alpha} [rad/s]','dot{\theta} [rad/s]'},...
    'InputName','Voltage [V]');



sys_eq=sys_pi;

discrete_eq=c2d(sys_eq,h);

[K,S,e] = dlqr(discrete_eq.A,discrete_eq.B,diag([30,1,1,1]),1);
[Kcatch,S,e] = dlqr(discrete_eq.A,discrete_eq.B,diag([1,1,2,1]),1);
K;

poles =log(e)/h;
% pDisc = real(exp(2*poles*h));
% pDisc(4)=0.5;

pCont=1*[-80,-81,-50,-51];%poles in s-domain
pDisc=exp(pCont.*h);%poles in z-domain
cont=place(sys_eq.A',sys_eq.C',pCont)';
disc=place(discrete_eq.A',discrete_eq.C',pDisc)';


KK=ss([],[],[],K,h);
fs=ss(discrete_eq.A,discrete_eq.B,eye(4),[],h);
constgain=ones(1,4)./dcgain(feedback(fs,KK))';
constgain(2:4)=0;

[Kqlip,S,e] = dlqr(discrete_eq.A,discrete_eq.B,diag([30,1,1,1]),1);
K_qli = [Kqlip,0.5,0];

