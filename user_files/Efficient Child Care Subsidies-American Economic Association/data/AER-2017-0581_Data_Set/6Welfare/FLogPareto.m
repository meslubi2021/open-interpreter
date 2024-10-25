function F=FLogPareto(y)

global gamma x d p pz

load ('..\5Pareto_Improving_Allocations\Utilitarian with concave preferences\ParetoLog.mat') 

for r=1:1
    val(r)=p*(log(x(r,1))-(1/theta)*(((x(r,2))^(1+gamma))/(1+gamma)));
end
for r=2:N
    val(r)=(1-p)*pz(r-1)*(log(x(r,1))-(1/theta)*((((x(r,3)/z(r-1))+x(r,2))^(1+gamma))/(1+gamma)));
end

load ('..\3Calibration_M\Concave\LogActual.mat') 

for r=1:1
    aval(r)=p*(log((y(1)+1)*d(r,1))-(1/theta)*(((d(r,2))^(1+gamma))/(1+gamma)));
end
for r=2:N
    aval(r)=(1-p)*pz(r-1)*(log((y(1)+1)*d(r,1))-(1/theta)*((((d(r,3)/z(r-1))+d(r,2))^(1+gamma))/(1+gamma)));
end

vec=ones(N,1);

optimal=val*vec;
actual=aval*vec;

F=[optimal-actual];