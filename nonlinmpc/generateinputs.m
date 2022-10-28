

swingupinputs=[];

figure(1);
clf;

sqrspace=@(bound,n)linspace(-sqrt(bound),sqrt(bound),n).*abs(linspace(-sqrt(bound),sqrt(bound),n));
linspacebound=@(bound,n)linspace(-bound,bound,n);

u0set=linspacebound(0.7,9);
umset=linspacebound(0.6,5);
u1set=linspacebound(0.5,3);

swQ=0.004;
swR=2000;
swRdot=1;
swEcost=10;
swAlphaMax=1;
swTs=0.01;
swCatch=25;

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

plot(samples,swingupinputs);





% x0=rand(4,1)*2-1;
x0=[0;0;0;0];
sim('hardware/simulation_lqr_nonlinmpc.slx',5);

