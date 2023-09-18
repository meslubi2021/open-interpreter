
clc
clear all

load ('..\4Optimal_Allocations\01Baseline.mat') 

wage=10*[0 z];

Bearnings1=earnings;
Bcare1=care;
Bconsumption1=consumption;

load ('..\4Optimal_Allocations\03Highw.mat') 

Bearnings3=earnings;
Bcare3=care;
Bconsumption3=consumption;

load ('..\4Optimal_Allocations\04Gamma2.mat') 

Bearnings4=earnings;
Bcare4=care;
Bconsumption4=consumption;

load ('..\4Optimal_Allocations\Utilitarian with concave preferences\ConcaveLog.mat') 

Cearnings=earnings;
Cconsumption=consumption;
Ccare=care;
Cu2=u;

figure(3);
set(gca,'FontSize',9)
hold on
subplot(2,2,1)
hold on
plot (wage,Bearnings4,':','LineWidth',1.5,'Color',[0.9 0.4 0]);
hold on
plot (wage,Bearnings3,'--','LineWidth',1.5,'Color',[0.8 0 0.8]);
hold on
plot (wage,Bearnings1,'-k','LineWidth',1.5);
hold on
plot (wage,Cearnings,'-.b','LineWidth',1.5);
hold on
set(gca,'FontSize',9)
title('(a) Earnings (y)','fontsize',9)
ylabel('Amount ($000)','fontsize',9)
xlabel('Wage ($)','fontsize',9)
ylabel('Amount ($000)','fontsize',9)
subplot(2,2,2)
hold on
plot (wage,Bconsumption4,':','LineWidth',1.5,'Color',[0.9 0.4 0]);
hold on
plot (wage,Bconsumption3,'--','LineWidth',1.5,'Color',[0.8 0 0.8]);
hold on
plot (wage,Bconsumption1,'-k','LineWidth',1.5);
hold on
plot (wage,Cconsumption,'-.b','LineWidth',1.5);
hold on
set(gca,'FontSize',9)
title('(b) Consumption (c)','fontsize',9)
ylabel ('Amount ($000)','fontsize',9)
xlabel('Wage ($)','fontsize',9)
subplot(2,2,3)
hold on
h4=plot (wage,Bcare4,':','LineWidth',1.5,'Color',[0.9 0.4 0]);
hold on
h3=plot (wage,Bcare3,'--','LineWidth',1.5,'Color',[0.8 0 0.8]);
hold on
h1=plot (wage,Bcare1,'-k','LineWidth',1.5);
hold on
h2=plot (wage,Ccare,'-.b','LineWidth',1.5);
hold on
set(gca,'FontSize',9)
title('(c) Child Care (h)','fontsize',9)
ylabel ('Effort','fontsize',9)
xlabel('Wage ($)','fontsize',9)
legend([h1 h3 h4 h2],{'Baseline','High Child Care','Low Labor Supply Elasticity','Log-Consumption Preferences'})
hold off



