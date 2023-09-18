function F=FRawlsUSA(y)

global gamma cons x d p pz

load ('..\4Optimal_Allocations\Rawlsian\Rawlsian.mat') 

for r=1:1
    val(r)=(x(r,1)-(1/theta)*(((x(r,2))^(1+gamma))/(1+gamma)));
end

load ('..\3Calibration_M\01ActualUSBaseline.mat') 

for r=1:1
    aval(r)=((1+y(1))*d(r,1)-(1/theta)*(((d(r,2))^(1+gamma))/(1+gamma)));
end

optimal=val;
actual=aval;

F=[optimal-actual];