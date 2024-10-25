%% US Tax and Benefit Scheme

clc
clear all

global w z pz N p theta gamma zu unem exempt m1 m2 m3 m4 m5 m6 inc1 inc2 inc3 inc4 inc5 ssrate ssbase eitceli eitcmax eitcin eitcout eitcinc dctcinc1 dctcinc2 dctcinc3 dctcinc4 dctcinc5 dctcinc6 dctcinc7 dctcinc8 dctcinc9 dctcinc10 dctcinc11 dctcinc12 dctcinc13 dctcinc14 dctcinc15 dctcrate1 dctcrate2 dctcrate3 dctcrate4 dctcrate5 dctcrate6 dctcrate7 dctcrate8 dctcrate9 dctcrate10 dctcrate11 dctcrate12 dctcrate13 dctcrate14 dctcrate15 dctcrate16 dctcmax ccdfsub ccdfinc1 ccdfinc2 ccdfinc3 ccdfrate1 ccdfrate2 ccdfrate3

%%%%%%%%%%%%%%%%
%% Parameters %% 
%%%%%%%%%%%%%%%%

N=11;

%% e=24 ; gamma=1 ; w=0.51                                    
n=24;                                                       % Normalisation

y(:,1)=[0 1000 5000 10000 15000 20000 25000 30000 35000 40000 45000]/(10*n*50);


%%%%%%%%%%%%%%%%
%% US System  %%
%%%%%%%%%%%%%%%%

% unem=5500/(10*50*n);                                        % Unemployment insurance benefits for a single mother with 2 children
unem=556/(10*50*n);                                        % Unemployment insurance benefits for a childless person

% exempt=(8400+3650*3)/(10*50*n);                          % Income tax deductions and allowances for single mother with 2 children
exempt=(5700+3650)/(10*50*n);                              % Income tax deductions and allowances for childless person
m1=0.1;                                                     % Marginal income tax rates
m2=0.15;    
m3=0.25;
m4=0.28;
m5=0.33;
m6=0.35;
inc1=8375/(10*50*n);                                        % Income tax thresholds
inc2=34000/(10*50*n);
inc3=82400/(10*50*n);
inc4=171850/(10*50*n);
inc5=373650/(10*50*n);

ssrate=0.08;                                                % Social Security tax rate for employees (note: employees + employers 15.3%)
ssbase=106800/(10*50*n);

% eitcmax=5036/(10*50*n);                                     % Maximum EITC credit for Single parent with two children
% eitcin=0.4;                                                 % Phase in rate
% eitcout=0.21;                                               % Phase out rate
% eitcinc=40363/(10*50*n);                                    % Earnings threshold  
% eitceli=16420/(10*50*n);                                    % Income where phase out start

eitcmax=457/(10*50*n);                                      % Maximum EITC credit for childless parent
eitcin=0.0765;                                              % Phase in rate
eitcout=0.0765;                                             % Phase out rate
eitcinc=13460/(10*50*n);                                    % Earnings threshold  
eitceli=7486/(10*50*n);                                     % Income where phase out start

dctcinc1=15000/(10*50*n);                                   % DCTC income threshold  
dctcinc2=17000/(10*50*n);
dctcinc3=19000/(10*50*n);
dctcinc4=21000/(10*50*n);
dctcinc5=23000/(10*50*n);
dctcinc6=25000/(10*50*n);
dctcinc7=27000/(10*50*n);
dctcinc8=29000/(10*50*n);
dctcinc9=31000/(10*50*n);
dctcinc10=33000/(10*50*n);
dctcinc11=35000/(10*50*n);
dctcinc12=37000/(10*50*n);
dctcinc13=39000/(10*50*n);
dctcinc14=41000/(10*50*n);
dctcinc15=43000/(10*50*n);
dctcrate1=0.35;                                             % DCTC rates
dctcrate2=0.34;
dctcrate3=0.33;
dctcrate4=0.32;
dctcrate5=0.31;
dctcrate6=0.30;
dctcrate7=0.29;
dctcrate8=0.28;
dctcrate9=0.27;
dctcrate10=0.26;
dctcrate11=0.25;
dctcrate12=0.24;
dctcrate13=0.23;
dctcrate14=0.22;
dctcrate15=0.21;
dctcrate16=0.2;
dctcmax=6000/(10*50*n);                                     % DCTC maximum credit

ccdfsub=0.9;                                                % Recommended subsidy rate according to Federal guidelines
ccdfinc1=17568/(10*50*n);                                   % Income thresholds
ccdfinc2=26325/(10*50*n);
ccdfinc3=32349/(10*50*n);
ccdfrate1=0.39;                                             % Proportion receiving the ccdf subsidy
ccdfrate2=0.24;
ccdfrate3=0.05;

%% Computing the Actual Tax Function based on Second Best Allocations

for r=1:N
    % Defining taxable(r) income
    taxable(r)=max(0,(y(r,1)-exempt));
    % Computing Federal taxes
    if taxable(r)>0.01 & taxable(r)<=inc1
        tax(r)=m1*taxable(r);
    elseif taxable(r)>inc1 & taxable(r)<=inc2
        tax(r)=m2*taxable(r);
    elseif taxable(r)>inc2 & taxable(r)<=inc3
        tax(r)=m3*taxable(r);
    elseif taxable(r)>inc3 & taxable(r)<=inc4
        tax(r)=m4*taxable(r);
    elseif taxable(r)>inc4 & taxable(r)<=inc5
        tax(r)=m5*taxable(r);
    elseif taxable(r)>inc5
        tax(r)=m6*taxable(r);
    else
        tax(r)=0;
    end
    % Computing Social Security tax
    ss(r)=min(ssrate*ssbase,ssrate*y(r,1));
    % Computing EITC benefits - Refundable tax credit
    if y(r,1)>0.001 & y(r,1)<eitceli 
       eitc(r)=min(eitcmax,eitcin*y(r,1));
    elseif y(r,1)>=eitceli & y(r,1)<eitcinc
       eitc(r)=min(eitcmax,(eitcmax-eitcout*(y(r,1)-eitceli)));
    else 
       eitc(r)=0;
    end  
    % Defining net income if agent is employed 
    if y(r,1)>0.08
        T(r)=tax(r)+ss(r)-eitc(r);
    else
        T(r)=-unem;
    end
    % Optimal subsidy
    atax(r)=T(r)*(10*n*50/1000);
end

atax0=mat2str(atax)


%% Graphs

wage=10*[0 z];

% Subsidy schemes in the USA
earnings=[1 5 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45];
dctc=[0.35 0.35 0.35 0.35 0.35 0.35 0.34 0.33 0.32 0.31 0.3 0.29 0.28 0.27 0.26 0.25 0.24 0.23 0.22 0.21 0.2];
ccdf=[0.35 0.35 0.35 0.35 0.35 0.35 0.35 0.21 0.21 0.21 0.21 0.04 0.04 0.04 0 0 0 0 0 0 0];
subusa=dctc+ccdf;

f=[0 1 2 3 4 5 6 7 8 9 10];
sub10=0.7*[0 1 2 3 4 5 6 6 6 6 6];
sub20=0.53*[0 1 2 3 4 5 6 6 6 6 6];
sub25=0.51*[0 1 2 3 4 5 6 6 6 6 6];
sub30=0.31*[0 1 2 3 4 5 6 6 6 6 6];
sub35=0.25*[0 1 2 3 4 5 6 6 6 6 6];
sub40=0.22*[0 1 2 3 4 5 6 6 6 6 6];

earn=[0 1 5 10 15 20 25 30 35 40 45];
tax0=[-0.556 0.0035 0.0175 0.600321 1.765 3.1975 4.3475 5.4975 6.6475 7.7975 12.5125];
tax2=[-5.5 -0.32 -1.6 -3.2 -3.836 -2.6192 -0.6692 1.8133 4.0133 6.2133 7.4475];
childall=tax0-tax2;

break

% Graphs

figure(1) 
subplot(2,2,1)
hold on
plot (earnings,subusa,'-k','LineWidth',1.5);
hold on
plot (earnings,dctc,'--b','LineWidth',1.75);
hold on
plot (earnings,ccdf,':','LineWidth',1.75,'Color',[0.8 0 0.8]);
hold on
title('(a) Subsidy Rate')
legend('USA','DCTC','CCDF')
xlabel('Earnings ($000)')
ylabel('Rate')
hold on
subplot(2,2,2)
hold on
plot (f,sub10,'-k^','LineWidth',1.5','MarkerSize',3,'Color',[0.2 0.2 0.2]);
hold on
plot (f,sub20,'-rx','LineWidth',1.5,'MarkerSize',4,'Color',[0.9 0.4 0]);
hold on
plot (f,sub30,'-o','LineWidth',1.5,'MarkerSize',3,'Color',[0 0.4 0.6]);
hold on
plot (f,sub40,'-+','LineWidth',1.5,'MarkerSize',3,'Color', [0.6 0 0.6]);
hold on
plot ([6 6],[0 10],':k','LineWidth',1);
hold on
title('(b) Subsidy Amount')
legend('y = $10k','y = $20k','y = $30k','y = $40k');
xlabel('Child care cost ($000)')
ylabel('Amount ($000)')
hold on
subplot(2,2,3)
hold on
plot (earn,tax0,'--k','LineWidth',1.75,'Color',[0.1 0.1 0.1]);
hold on
plot (earn,tax2,'-.r','LineWidth',1.75,'Color',[0.9 0 0]);
hold on
plot (earn,childall,'-b','LineWidth',1.5,'Color',[0 0 0.8]);
hold on
plot ([0 45],[0 0],':k','LineWidth',1);
hold on
title('(c) Taxes and Allowances')
legend('Net Taxes (T0): no children','Net Taxes (T2): 2 children','Child Allowances: T0-T2');
xlabel('Earnings ($000)')
ylabel('Amount ($000)')
hold off

