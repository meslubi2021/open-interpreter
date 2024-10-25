function F=FHighwUSA(y)

global gamma x d p pz

load ('..\4Optimal_Allocations\03Highw.mat') 

for r=1:N
    phi(r)=1/(u(r)*(1000/(10*n*50)));
end

for r=1:1
    val(r)=p*(phi(r)*(x(r,1)-(1/theta)*(((x(r,2))^(1+gamma))/(1+gamma))));
end
for r=2:N
    val(r)=(1-p)*pz(r-1)*(phi(r)*(x(r,1)-(1/theta)*((((x(r,3)/z(r-1))+x(r,2))^(1+gamma))/(1+gamma))));
end

load ('..\3Calibration_M\03ActualUSHighw.mat') 

for r=1:1
    aval(r)=p*(phi(r)*((1+y(1))*d(r,1)-(1/theta)*(((d(r,2))^(1+gamma))/(1+gamma))));
end
for r=2:N
    aval(r)=(1-p)*pz(r-1)*(phi(r)*((1+y(1))*d(r,1)-(1/theta)*((((d(r,3)/z(r-1))+d(r,2))^(1+gamma))/(1+gamma))));
end

vec=ones(N,1);

optimal=val*vec;
actual=aval*vec;

F=[optimal-actual];