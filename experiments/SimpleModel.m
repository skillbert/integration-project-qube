function [A,B,C,D] = SimpleModel(A32, A33, A42, A43, B3, B4,Ts)

A= [0 0 1 0; 0 0 0 1; 0 A32 A33 0; 0 A42 A43 0] ;
B = [0; 0; B3; B4] ;
C = [eye(2),zeros(2)];
D = zeros(2,1);

end 