function sys=linearized(nonlin,q,q_dot,F,value)

ssvars=[q;q_dot;F];
at_eq=subs(nonlin,q,q-value);

divs=simplify(subs(jacobian(at_eq,ssvars),[q;q_dot],[value;zeros(size(q_dot))]));
sys.A=[
    0,0,1,0
    0,0,0,1
    divs(1,1:4)
    divs(2,1:4)
];
sys.B=[
    0
    0
    divs(1,5)
    divs(2,5)
];
sys.C=sym([
    1,0,0,0
    0,0,1,0
]);
sys.D=sym(zeros(2,1));