function [A,B,C,D] = SimpleModel(a11, a12, a13, a14, a21, a22,Ts)

C_p = 0;
sigma = a12*a22 - a13^2 ;

A= [0 0 1 0; 0 0 0 1; 0 a13*a21 -a11*a22 C_p*a13; 0 -a12*a21 a11*a13 C_p*a12]/sigma ;
B = [0; 0; -a14*a22; a13*a14]/sigma ;
C = [eye(2),zeros(2)];
D = zeros(2,1);

end 