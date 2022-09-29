
run(sprintf('experiments/%s',configname));

model=@(alpha,theta,alpha_dot,theta_dot,u)[((alpha_dot.*(-2.46872604672e-5)+u.*1.9980288e-3+theta_dot.^2.*sin(theta).*9.47552256e-7+cos(theta).*sin(theta).*4.5993298176e-4+theta_dot.*cos(theta).*4.11264e-6).*(-5.0./8.4e+1))./(cos(theta).^2.*5.992704e-8-1.4533632e-7);((theta_dot.*5.29872e-6+sin(theta).*5.9257705248e-4-alpha_dot.*cos(theta).*1.31151071232e-5+u.*cos(theta).*1.0614528e-3+theta_dot.^2.*cos(theta).*sin(theta).*5.03387136e-7).*(5.0./4.2e+1))./(cos(theta).^2.*5.992704e-8-1.4533632e-7)];

runmodel=@(t,x)[x(3);x(4);model(x(1),x(2),x(3),x(4),u(1+floor(t/T*length(u))))];

timesraw=timesraw(1:end-1);
[t,y]=ode45(runmodel,timesraw,[0;0;0;0]);
plot(t,y(:,1:2));
legend alpha theta




x0=[0;0;0;0];
xout=zeros(length(x0),length(u));
t=0;
x=x0;
simstep=0.001;
while t<T
    xd=runmodel(t,x);
    x=x+xd*simstep;
    t=t+simstep;
    if mod(t,h)~=mod(t-simstep,h)
        xout(:,1+floor(t/T*length(u)))=x;
    end
end





% signalnames={'in','alpha','theta'};
% plot(timesraw,[u',1]);
% legend(signalnames);










