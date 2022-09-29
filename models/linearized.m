function sys=linearized(nonlin,q,q_dot,F,value)

at_eq=subs(nonlin,q,q-value);

subvalues=sym([]);
for i=1:length(q)
    subvalues(end+1,:)=[sin(q(i)),q(i)];
    subvalues(end+1,:)=[sin(2*q(i)),2*q(i)];
    subvalues(end+1,:)=[cos(q(i)),1];
    subvalues(end+1,:)=[q(i)^2,0];
    subvalues(end+1,:)=[q_dot(i)^2,0];
end

lin=simplify(subs(at_eq,subvalues(:,1),subvalues(:,2)));

ssvars=[q;q_dot;F];

sys_abcd=simplify([
    0,0,1,0,0
    0,0,0,1,0
    matrixinsert(lin(1),ssvars)'
    matrixinsert(lin(2),ssvars)'
    1,0,0,0,0
    0,0,1,0,0
]);

sys.A=sys_abcd(1:4,1:4);
sys.B=sys_abcd(1:4,5);
sys.C=sys_abcd(5:6,1:4);
sys.D=sys_abcd(5:6,5);