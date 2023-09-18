function value=V(x)

global w z pz Nz N p theta gamma G

for r=1:1
    val(r)=p*(x(r,1)-(1/theta)*(((x(r,2))^(1+gamma))/(1+gamma)));
end

value=-val;
