function x_ddot = generated_nonlinfit(in1,in2,u)
%GENERATED_NONLINFIT
%    X_DDOT = GENERATED_NONLINFIT(IN1,IN2,U)

%    This function was generated by the Symbolic Math Toolbox version 9.0.
%    26-Oct-2022 21:30:39

alpha = in1(1,:);
alpha_dot = in2(1,:);
theta = in1(2,:);
theta_dot = in2(2,:);
t2 = cos(theta);
t3 = sin(theta);
t4 = theta_dot.^2;
t5 = t2.^2;
t6 = t5.*5.202e-4;
t7 = t6-1.025001736928224e-3;
t8 = 1.0./t7;
et1 = alpha.*(-1.861031175243817e-2)-alpha_dot.*2.355807420816275e-3+u.*7.776000919769337e-1;
et2 = t2.*t3.*6.32066282169313e-2+t3.*t4.*5.283326721496806e-4+t2.*theta_dot.*5.2382775346984e-5;
et3 = t3.*1.270331445249629e-4;
et4 = theta_dot.*1.052792857172148e-7-alpha.*t2.*1.898251798748694e-5;
et5 = alpha_dot.*t2.*(-2.402923569232601e-6)+t2.*u.*7.931520938164723e-4+t2.*t3.*t4.*5.388993255926742e-7;
x_ddot = [t8.*(et1+et2).*(-9.498560782889175e-1);t8.*(et3+et4+et5).*9.653008925700381e+2];
