%% calibrate alpha

load 'calibrate_alpha.mat'

figure(1)
clf
plot(y(:,1))

alpha_indices = [85,327,665,948,1375,1706,2000];
alpha_thruth = [0,1/4,1/2,3/4,-1/4,-1/2,-3/4]'*pi; %real values
alpha_sensor_angles = y(alpha_indices,1);

% y= ax+b y=real value, x= sensor value, b=bias
X=[ones(size(alpha_sensor_angles)),alpha_sensor_angles];
%linear regression
b_alpha = X\alpha_thruth;

figure(2)
clf

hold on
plot(alpha_sensor_angles,alpha_thruth,'x')
syms x
fplot([1,x]*b_alpha)
xlim([-3.5,3.5]);
ylim([-3.5,3.5]);
xlabel 'sensor output'
ylabel '\alpha measurements (rad)'
title '\alpha sensor values vs measurements'
saveas(gcf,'calibration/calibrate_alpha','epsc')

fprintf('alpha regressions alpha=a*y+b=%f*y+%f\n',b_alpha(2),b_alpha(1));

%% calibrate gamma

load 'calibrate_gamma_stepped.mat'

figure(3)
clf
plot(y(:,2))

gamma_indices = [36,350,875,1391,1915,2577];
gamma_thruth = [0,1/2,1,3/2,2,4]'*pi; %real values
gamma_sensor_angles = y(gamma_indices,2);

% y= ax+b y=real value, x= sensor value, b=bias
X=[ones(size(gamma_sensor_angles)),gamma_sensor_angles];
%linear regression
b_gamma = X\gamma_thruth;

figure(4)
clf

hold on
plot(gamma_sensor_angles,gamma_thruth,'x')
syms x
fplot([1,x]*b_gamma)
xlim([-1,13]);
ylim([-1,13]);
xlabel 'sensor output'
ylabel '\gamma measurements (rad)'
title '\gamma sensor values vs measurements'
saveas(gcf,'calibration/calibrate_gamma','epsc')

fprintf('alpha regressions alpha=a*y+b=%f*y+%f\n',b_gamma(2),b_gamma(1));

