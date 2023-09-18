
clc
clear all

%% Optimal

load ('..\4Optimal_Allocations\01Baseline.mat') 

uBaseline=u*(1000/(10*n*50));

uB=u;
yB=earnings;
cB=consumption;

%% Pareto Improving 

load ('..\5Pareto_Improving_Allocations\Baseline\ParetoBaseline.mat') 

uBaselineP=u*(1000/(10*n*50));

uBP=u;
yBP=earnings;
cBP=consumption;

%% Actual

load ('..\3Calibration_M\01ActualUSBaseline.mat') 

uActual=u*(1000/(10*n*50));
cActual=consumption*(1000/(10*n*50));

uA=u;
cA=consumption;
yA=earnings;

%% Welfare gains

uDiffB=uBaseline-uActual;                                             
CEB=(uDiffB./cActual')*100;

uDiffBP=uBaselineP-uActual;                                             
CEBP=(uDiffBP./cActual')*100;

%% Graphs 

figure(4);
hold on
subplot(2,2,1)
hold on
plot(wage,yB,'-k','LineWidth',1.5)
hold on
plot(wage,yBP,'--','LineWidth',1.5,'Color',[0.8 0 0.8])
hold on
plot(wage,yA,'bo','MarkerSize',2)
hold on
set(gca,'FontSize',9)
title('(a) Earnings (y)','fontsize',9)
ylabel('Amount ($000)','fontsize',9)
xlabel('Wage ($)','fontsize',9)
legend ('Baseline','Baseline Pareto','USA')
subplot(2,2,2)
hold on
plot(wage,cB,'-k','LineWidth',1.5)
hold on
plot(wage,cBP,'--','LineWidth',1.5,'Color',[0.8 0 0.8])
hold on
plot(wage,cA,'bo','MarkerSize',2)
hold on
set(gca,'FontSize',9)
title('(b) Consumption (c)','fontsize',9)
ylabel('Amount ($000)','fontsize',9)
xlabel('Wage ($)','fontsize',9)
subplot(2,2,3)
hold on
plot(wage,CEB,'-k','LineWidth',1.5)
hold on
plot(wage,CEBP,'--','LineWidth',1.5,'Color',[0.8 0 0.8])
hold on
plot ([0 33],[0 0],':k','LineWidth',1);
hold on
set(gca,'FontSize',9)
title('(c) Welfare Gains (%)','fontsize',9)
ylabel('Consumption-Equivalent %','fontsize',9)
xlabel('Wage ($)','fontsize',9)
hold off

