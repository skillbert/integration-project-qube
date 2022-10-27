

swingupinputs=[];

figure(1);
clf;

sqrspace=@(bound,n)linspace(-sqrt(bound),sqrt(bound),n).*abs(linspace(-sqrt(bound),sqrt(bound),n));
linspacebound=@(bound,n)linspace(-bound,bound,n);

u0set=sqrspace(0.8,7);
umset=linspacebound(0.6,5);
u1set=linspacebound(0.5,3);

swQ=0.005;
swR=1000;
swRdot=0.02;
swTs=0.01;
swCatch=20;

ts=swTs;
tend=ts*8;
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

plot(samples,swingupinputs);






sim('hardware/simulation_lqr_nonlinmpc.slx',3);

