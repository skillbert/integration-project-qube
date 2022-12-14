

swingupinputs=[];


sqrspace=@(bound,n)linspace(-sqrt(bound),sqrt(bound),n).*abs(linspace(-sqrt(bound),sqrt(bound),n));
linspacebound=@(bound,n)linspace(-bound,bound,n);

u0set=linspacebound(0.8,11);
umset=linspacebound(0.7,5);
u1set=linspacebound(0.5,3);

%swingup tuning parameters
swR=0.004;
swRdot=1;
swQ=2000;
swEcost=10;
swAlphaMax=1.1;
swTs=0.01;
swCatch=15;

ts=swTs;
tend=ts*10;
samples=0:ts:tend;
for u0=u0set
    for um=umset
        for u1=u1set
            a = u0;
            b = -3*u0 + 4*um - u1;
            c = 2*u0 - 4*um + 2*u1;
            u=[];
            for t=samples
                t=t/tend;
                u(end+1)=a+b*t+c*t^2;
            end
            swingupinputs=[swingupinputs,u'];
        end
    end
end

figure(1);
clf;
plot(samples,swingupinputs);
xlabel 'time (sec)'
ylabel 'input u'
title 'Input curves subset'
saveas(gcf,['reportplots/nonlinmpcinputs.eps'],'epsc');





% x0=rand(4,1)*2-1;
x0=[0;0;0;0];
% sim('hardware/simulation_lqr_nonlinmpc.slx',5);

