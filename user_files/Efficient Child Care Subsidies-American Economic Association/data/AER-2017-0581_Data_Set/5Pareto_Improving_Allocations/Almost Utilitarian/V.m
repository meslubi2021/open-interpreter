function value=V(x)

global w z pz Nz N p theta gamma G n Au1 rho

for r=1:1
    val(r)=p*((x(r,1)-(1/theta)*(((x(r,2))^(1+gamma))/(1+gamma)))^rho);
end
for r=2:N
    val(r)=(1-p)*pz(r-1)*((x(r,1)-(1/theta)*((((x(r,3)/z(r-1))+x(r,2))^(1+gamma))/(1+gamma)))^rho);
end

vec=ones(N,1);
value=-(val*vec)^(1/rho);
