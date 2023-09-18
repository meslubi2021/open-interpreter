
%% Calibrating theta by matching mean labor supply predicted by our model with mean labor supply in CPS data
% For theta in Table B3
% Logarithmic felicity of consumption

clc
clear all

global w z pz N p theta gamma zu unem exempt m1 m2 m3 m4 m5 m6 inc1 inc2 inc3 inc4 inc5 ssrate ssbase eitceli eitcmax eitcin eitcout eitcinc dctcinc1 dctcinc2 dctcinc3 dctcinc4 dctcinc5 dctcinc6 dctcinc7 dctcinc8 dctcinc9 dctcinc10 dctcinc11 dctcinc12 dctcinc13 dctcinc14 dctcinc15 dctcrate1 dctcrate2 dctcrate3 dctcrate4 dctcrate5 dctcrate6 dctcrate7 dctcrate8 dctcrate9 dctcrate10 dctcrate11 dctcrate12 dctcrate13 dctcrate14 dctcrate15 dctcrate16 dctcmax ccdfsub ccdfinc1 ccdfinc2 ccdfinc3 ccdfrate1 ccdfrate2 ccdfrate3

%%%%%%%%%%%%%%%%
%% Parameters %% 
%%%%%%%%%%%%%%%%

w=0.51;                                                     % Cost of formal child care based on 2010 average child care cost
                                                            % Market productivity type (normalised by dividing by 10)
z=0.1*[2.4 3.75 4.08 4.32 4.54 4.72 4.85 4.97 5.08 5.19 5.29 5.43 5.54 5.63 5.76 5.88 6 6.13 6.23 6.36 6.5 6.66 6.8 7.02 7.21 7.34 7.52 7.71 8.01 8.33 8.69 9 9.37 9.61 10 10.31 10.83 11.53 12.01 12.5 13.46 14 14.57 15.71 16.82 18.51 20 22.36 25.64 32.21];

N=50;

%% e=24 ; gamma=1 ; w=0.51                                    
n=24;                                                       % Normalisation
gamma=1;                                                    % Effort felicity parameter
Nt=21;                                                      % Grid over theta
thetagrid=linspace(1.35,1.45,Nt);

%% Empirical distributions
pz=0.02*ones(N,1);                                          % Distribution of z based on 2010 March CPS z distribution
p=0.17;                                                     % Probability of being unlucky or not working

%%%%%%%%%%%%%%%%
%% US System  %%
%%%%%%%%%%%%%%%%

unem=5500/(10*50*n);                                        % Unemployment insurance benefits

exempt=(8400+3650*3)/(10*50*n);                             % Income tax deductions and allowances
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

eitcmax=5036/(10*50*n);                                     % Maximum EITC credit for Single parent with two children
eitcin=0.4;                                                 % Phase in rate
eitcout=0.21;                                               % Phase out rate
eitcinc=40363/(10*50*n);                                    % Earnings threshold  
eitceli=16420/(10*50*n);                                    % Income where phase out start

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Individual Optimisation US %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

options=optimset('LargeScale','on','MaxFunEvals',1000000,'Display','Iter','MaxIter',100000);

% Initial values
initU=[unem 0.5 0.01];
% initU=1*ones(1,3);
% lbU=1e-10*ones(1,3);
ubU=100*ones(1,3);
ubU(1,2)=1;

initv=[0.375 0.550800011879206 0];

% Those with employment opportunities
for i=1:N
    for r=1:Nt
        theta=thetagrid(r);
        zu=z(i);
        x(i,r,:)=fmincon(@V,initv,[],[],[],[],[],ubU,@myconV,options);
        v(i,r)=log(x(i,r,1))-(1/theta)*(((x(i,r,2))^(1+gamma))/(1+gamma));
        d(i,r,:)=fmincon(@U,initU,[],[],[],[],[],ubU,@myconU,options);
        u(i,r)=log(d(i,r,1))-(1/theta)*((((d(i,r,3)/zu)+d(i,r,2))^(1+gamma))/(1+gamma));
        if u(i,r)<v(i,r)
            d(i,r,:)=x(i,r,:);
        end
        hours(i,r)=d(i,r,3)/zu;
    end
end

%% Matching

% Hours predicted by the model for each z and each point in thetagrid
for r=1:Nt
    zero(r)=sum(hours(:,r)==0);
    pz=0.02*ones(N-zero(r),1);
    for i=1:N-zero(r)
        labor(i)=hours(zero(r)+i,r);
    end
    ahours(r)=pz'*labor';
    clear pz labor
end

% Hours observed from data for each z
data=(1/(n*50))*[1441 1312 1186 1098 1153 1517 799 865 1090 492 825 1297 613 915 1494 1094 1133 1055 1375 1253 1353 1122 1223 1379 1620 1205 1431 1228 1395 1437 1702 1567 1700 1525 1625 1700 1679 1820 1854 1700 1854 1872 1594 1882 1927 1732 1902 1970 1852 1505];

for r=1:Nt
    zero(r)=sum(hours(:,r)==0);
    pz=0.02*ones(N-zero(r),1);
    for i=1:N-zero(r)
        labordata(i)=data(zero(r)+i);
    end
    adata(r)=pz'*labordata';
    clear pz labordata
end

% Method of moments estimator
for r=1:Nt
    aresid(r)=(ahours(r)-adata(r)).^2;
    aabsresid(r)=abs(ahours(r)-adata(r));
end

% Finding the minimum and corresponding theta
[C,I]=min(aresid);
thetamacro=thetagrid(I);

[C,I]=min(aabsresid);
thetamacroabs=thetagrid(I);

theta=[thetamacro thetamacroabs]

save LogActual.mat

beep




