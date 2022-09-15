load 'data/calibrate_alpha.mat'

%% linear regression 

% y = a(x-b) / y= ax+b, y=real value, x= sensor value, b=bias
figure(1)
clf
hold on
plot(y(:,1))
plot(y(:,2))

radians_alpha = [3/4 0.5 1/4 0 -1/4 -0.5 -3/4]'*pi ; %real values
alpha_sensor_angles = [2.37 1.56 0.79 0 -0.73 -1.53 -2.38]' ; % fill it in from sensor

X= [ones(size(radians_alpha)),alpha_sensor_angles];
b_alpha = X\radians_alpha ;

figure(2)
clf

hold on
plot(radians_alpha,alpha_sensor_angles,'x')
syms x
fplot([1,x]*b_alpha)