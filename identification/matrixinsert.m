function m=matrixinsert(poly,vars)
    
m=sym(zeros(size(vars)));

[values,coeffvars]=coeffs(poly,vars);

for i=1:length(values)
    index=find(vars==coeffvars(i));
    if isempty(index)
        disp 'unexpected nonlinear component'
        pretty(coeffvars(i));
        pretty(values(i));
    end
    m(index)=values(i);
end
