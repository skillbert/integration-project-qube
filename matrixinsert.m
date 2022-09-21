function m=matrixinsert(poly,vars)
    
m=sym(zeros(size(vars)));

[values,coeffvars]=coeffs(poly,vars);

for i=1:length(values)
    m(find(vars==coeffvars(i)))=values(i);
end
