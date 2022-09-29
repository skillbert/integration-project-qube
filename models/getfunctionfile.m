function str=getfunctionfile(sys,name,vars)
nl=newline;

args=char(matlabFunction(sym(0),'Vars',vars));
opening=strfind(args,'(');
closing=strfind(args,')');

str=['function [A,B,C,D]=',name,args(opening:closing-1)];


A=char(matlabFunction(sys.A,'Vars',vars));
B=char(matlabFunction(sys.B,'Vars',vars));
C=char(matlabFunction(sys.C,'Vars',vars));
D=char(matlabFunction(sys.D,'Vars',vars));


str=[str,')',nl];
str=[str,'A=',A(closing+1:end),';',nl];
str=[str,'B=',B(closing+1:end),';',nl];
str=[str,'C=',C(closing+1:end),';',nl];
str=[str,'D=',D(closing+1:end),';',nl];

