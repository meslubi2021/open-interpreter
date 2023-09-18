
clc
clear all

%% Quasi-Linear

% Optimal

load ('..\4Optimal_Allocations\01Baseline.mat') 

uLinear1=u*(1000/(10*n*50));

uB=u;
yB=earnings;

load ('..\4Optimal_Allocations\02e34.mat') 

uLinear2=u*(1000/(10*n*50));

u1e34=u;
y1e34=earnings;

load ('..\4Optimal_Allocations\03Highw.mat') 

uLinear3=u*(1000/(10*n*50));

uHighw=u;
yHighw=earnings;

load ('..\4Optimal_Allocations\04Gamma2.mat') 

uLinear4=u*(1000/(10*n*50));

uGamma2=u;
yGamma2=earnings;

load ('..\4Optimal_Allocations\Rawlsian\Rawlsian.mat') 

uRawls=u*(1000/(10*n*50));

uR=u;
yR=earnings;

% Pareto improving

load ('..\5Pareto_Improving_Allocations\Baseline\ParetoBaseline.mat') 

uPareto1=u*(1000/(10*n*50));

uP1=u;
yP1=earnings;

load ('..\5Pareto_Improving_Allocations\Almost Utilitarian\ParetoRho99.mat') 

uPareto2=u*(1000/(10*n*50));

uP2=u;
yP2=earnings;

% Actual

load ('..\3Calibration_M\01ActualUSBaseline.mat') 

uActual=u*(1000/(10*n*50));
cActual=consumption*(1000/(10*n*50));

load ('..\3Calibration_M\02ActualUS1e34.mat') 

uActual1e34=u*(1000/(10*n*50));
cActual1e34=consumption*(1000/(10*n*50));

load ('..\3Calibration_M\03ActualUSHighw.mat') 

uActualHighw=u*(1000/(10*n*50));
cActualHighw=consumption*(1000/(10*n*50));

load ('..\3Calibration_M\04ActualUSGamma2.mat') 

uActualGamma2=u*(1000/(10*n*50));
cActualGamma2=consumption*(1000/(10*n*50));

% Welfare gains

uDiff=uLinear1-uActual;                                             
CEB=(uDiff./cActual')*100;

uDiff=uLinear2-uActual1e34;                                             
CE1e34=(uDiff./cActual1e34')*100;

uDiff=uLinear3-uActualHighw;                                             
CEHighw=(uDiff./cActualHighw')*100;

uDiff=uLinear4-uActualGamma2;                                             
CEGamma2=(uDiff./cActualGamma2')*100;

uDiff=uRawls-uActual;                                             
CER=(uDiff./cActual')*100;

uDiff=uPareto1-uActual;                                             
CEP1=(uDiff./cActual')*100;

uDiff=uPareto2-uActual;                                             
CEP2=(uDiff./cActual')*100;

%% Log (c)

load ('..\4Optimal_Allocations\Utilitarian with concave preferences\ConcaveLog.mat') 

uLog=u*(1000/(10*n*50));

uL=u;
yL=earnings;

load ('..\5Pareto_Improving_Allocations\Utilitarian with concave preferences\ParetoLog.mat') 

uLogLP=u*(1000/(10*n*50));

uLP=u;
yLP=earnings;

load ('..\3Calibration_M\Concave\LogActual.mat') 

uActualL=u*(1000/(10*n*50));
cActualL=consumption*(1000/(10*n*50));

uDiff=uLog-uActualL;                                    
CEL=(exp(uDiff)-1)*100;

uDiff=uLogLP-uActualL;                                    
CELP=(exp(uDiff)-1)*100;

%% Graph

figure(2);
set(gca,'FontSize',9)
hold on
subplot(2,2,1)
hold on
h4=plot (wage,CEGamma2,'-.b','LineWidth',1.5);
hold on
h3=plot (wage,CEHighw,'--','LineWidth',1.5,'Color', [0.9 0.4 0]);
hold on
h2=plot (wage,CE1e34,':','LineWidth',1.5,'Color',[0 0.6 0.5]);
hold on
h1=plot (wage,CEB,'-k','LineWidth',1.5);
hold on
plot ([0 33],[0 0],':k','LineWidth',1);
hold on
set(gca,'FontSize',9)
title('(a) Log Social Welfare','fontsize',9)
ylabel('Consumption-Equivalent %','fontsize',9)
xlabel('Wage ($)','fontsize',9)
legend([h1 h2 h3 h4],{'Baseline','1e=34','w=6.4','\gamma=2'})
hold on
subplot(2,2,2)
hold on
h1=plot (wage,CER,'-b','LineWidth',1.2);
hold on
h2=plot (wage,CEL,'-.k','LineWidth',1.5);
hold on
plot ([0 33],[0 0],':k','LineWidth',1);
hold on
set(gca,'FontSize',9)
title('(b) Rawlsian and Utilitarian','fontsize',9)
ylabel('Consumption-Equivalent %','fontsize',9)
xlabel('Wage ($)','fontsize',9)
legend([h1 h2],{'Rawls','log(c)'})
subplot(2,2,3)
hold on
h2=plot (wage,CELP,'-.k','LineWidth',1.5);
hold on
h3=plot (wage,CEP1,'--','LineWidth',1.5,'Color',[0.8 0 0.8]);
hold on
h4=plot (wage,CEP2,':','LineWidth',1.5,'Color', [0 0.6 0.5]);
hold on
plot ([0 33],[0 0],':k','LineWidth',1);
hold on
set(gca,'FontSize',9)
title('(c) Pareto Improving','fontsize',9)
ylabel('Consumption-Equivalent %','fontsize',9)
xlabel('Wage ($)','fontsize',9)
legend([h3 h4 h2],{'Baseline Pareto (\rho=0)','Low Redistribution (\rho=0.99)', 'Pareto log(c) (\rho=1)'})
subplot(2,2,4)
hold on
h2=plot (wage,CELP,'-.k','LineWidth',1.5);
hold on
h3=plot (wage,CEP1,'--','LineWidth',1.5,'Color',[0.8 0 0.8]);
hold on
h4=plot (wage,CEP2,':','LineWidth',1.5,'Color', [0 0.6 0.5]);
hold on
plot ([0 33],[0 0],':k','LineWidth',1);
hold on
set(gca,'FontSize',9)
title('(d) Pareto Improving (zoomed)','fontsize',9)
ylabel('Consumption-Equivalent %','fontsize',9)
xlabel('Wage ($)','fontsize',9)
hold off