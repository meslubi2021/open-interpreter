
%% Computation of welfare and parameter M under the current US tax and benefit system (agent's private optimization problem)
% For M in Table B3
% Logarithmic felicity of consumption

clc
clear all

global w z pz N p theta gamma zu unem exempt m1 m2 m3 m4 m5 m6 inc1 inc2 inc3 inc4 inc5 ssrate ssbase eitceli eitcmax eitcin eitcout eitcinc dctcinc1 dctcinc2 dctcinc3 dctcinc4 dctcinc5 dctcinc6 dctcinc7 dctcinc8 dctcinc9 dctcinc10 dctcinc11 dctcinc12 dctcinc13 dctcinc14 dctcinc15 dctcrate1 dctcrate2 dctcrate3 dctcrate4 dctcrate5 dctcrate6 dctcrate7 dctcrate8 dctcrate9 dctcrate10 dctcrate11 dctcrate12 dctcrate13 dctcrate14 dctcrate15 dctcrate16 dctcmax ccdfsub ccdfinc1 ccdfinc2 ccdfinc3 ccdfrate1 ccdfrate2 ccdfrate3

%%%%%%%%%%%%%%%%
%% Parameters %% 
%%%%%%%%%%%%%%%%

w=0.51;                                                     % Cost of formal child care based on 2010 average child care cost
                                                            % Market productivity type (normalised by dividing by 10)
z=0.1*[2.40 3.75 4.08 4.32 4.54 4.72 4.85 4.97 5.08 5.19 5.29 5.43 5.54 5.63 5.76 5.88 6 6.13 6.23 6.36 6.5 6.66 6.8 7.02 7.21 7.34 7.52 7.71 8.01 8.33 8.69 9 9.37 9.61 10 10.31 10.83 11.53 12.01 12.5 13.46 14 14.57 15.71 16.82 18.51 20 22.36 25.64 32.21];

Nz=50;
N=51;

%% e=24 ; gamma=1 ; w=0.51                                    
n=24;                                                       % Normalisation
gamma=1;                                                    % Effort felicity parameter
theta=1.39;                                                 % Effort cost type types

%% Empirical distributions
pz=0.02*ones(Nz,1);                                         % Distribution of z based on 2010 March CPS z distribution
p=0.11;                                                     % Probability of being unlucky

%%%%%%%%%%%%%%%%
%% US System  %%
%%%%%%%%%%%%%%%%

unem=5500/(10*50*n);                                        % Unemployment insurance benefits

exempt=(8400+3650*3)/(10*50*n);                          % Income tax deductions and allowances
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

% Note: d(1) already include the CCDF subsidy

options=optimset('LargeScale','on','MaxFunEvals',1000000,'Display','Iter','MaxIter',100000);

% Initial values
initU=1*ones(1,3);
% lbU=1e-10*ones(1,3);
ubU=100*ones(1,3);
ubU(1,2)=1;

% e=24 ; gamma=1 ; w=0.51  
initu=[0.458333289198874 0.99999991346177 0;0.458333289198874 0.99999991346177 0;0.458333289198874 0.99999991346177 0;0.458333289198874 0.99999991346177 0;0.458333289198874 0.99999991346177 0;0.458333289198874 0.99999991346177 0;0.458333289198874 0.99999991346177 0;0.458333289198874 0.99999991346177 0;0.458333289198874 0.99999991346177 0;0.458333289198874 0.99999991346177 0;0.458333289198874 0.99999991346177 0;0.674234440381538 7.412023254886e-08 0.761533648370083;0.695605428730156 7.27977709219315e-08 0.777723791390014;0.712411309640176 7.18465695315968e-08 0.790455519590687;0.7261704173692 7.111864640729e-08 0.800879086234492;0.746057982433972 7.0140272017387e-08 0.815945423650101;0.764428759433423 1.84831761082029e-06 0.829862233074824;0.782811536209067 1.82754760660363e-06 0.843788584325064;0.802738856989198 1.80663218169817e-06 0.858885044706084;0.81807599066466 1.79155887783395e-06 0.870504089148923;0.838024662976604 1.77315846514571e-06 0.885616724302159;0.859520241307058 1.75471138663191e-06 0.901901257965973;0.884101347497311 1.73518434885009e-06 0.92052331300657;0.905621920945274 1.71931759074341e-06 0.936826781718436;0.939461094865348 1.69641496060928e-06 0.96246252527956;0.968705079661208 1.67839607825109e-06 0.984617063734014;0.988723890091639 6.29775780127324e-08 0.999783234277746;1.01645389681836 6.24143561360144e-08 1.02079081527261;1.0457386093734 6.18613794092965e-08 1.04297620371046;1.05401826208748 0.000327138270555944 1.04916665347947;1.05447019467646 0.0016931546094071 1.04916629858834;1.05450776500935 0.00180645347211281 1.04916636260165;1.05410021329445 0.000574680815021101 1.04916666640567;1.0616351047563 1.47296064397687e-06 1.05756298973301;1.08764291229452 1.44864843060276e-06 1.08583235449967;1.12990807859609 1.41304323279742e-06 1.13177276546332;1.1635054450386 1.38770360538769e-06 1.16829165114771;1.21986579575655 1.35841622994633e-06 1.22955291246489;1.29574151938135 1.31509374287629e-06 1.31202654068675;1.34756686947287 7.01459445205901e-05 1.36833358239996;1.34815470401349 0.00184713127021986 1.36833330041746;1.34822665096532 0.00206492542355503 1.36833301594225;1.37490787495146 1.53973160552459e-06 1.40687422344936;1.38284304857875 1.61954555019811e-06 1.51502216106055;1.47757579783887 1.53324505949602e-06 1.64844861706971;1.56990509246444 1.46636351852614e-06 1.77848991477029;1.71061254210636 1.38696523822627e-06 1.97666946602182;1.78774722138618 1.42132454651598e-06 2.20814065135684;1.98491713908815 1.35315959030063e-06 2.48584480755654;2.018941207598 6.74586277678482e-07 2.5346416165527;2.41992407189092 1.28960030057868e-06 3.33719980753814];

% Those without employment opportunities
for i=1:1
    initU=initu(i,:);
    d(i,:)=fmincon(@V,initU,[],[],[],[],[],ubU,@myconV,options);
end

% Those with employment opportunities
for i=2:N
    zu=z(i-1);
    initU=initu(i,:);
    d(i,:)=fmincon(@U,initU,[],[],[],[],[],ubU,@myconU,options);
end

% Computing Utility
u(1)=log(d(1,1))-(1/theta)*(((d(1,2))^(1+gamma))/(1+gamma));
for i=2:N
    u(i)=log(d(i,1))-(1/theta)*((((d(i,3)/z(i-1))+d(i,2))^(1+gamma))/(1+gamma));
end

% Comparing utility of employed with unemployed
for i=2:N
    if u(i)<u(1)
        u(i)=u(1);
        d(i,:)=d(1,:);
    end
end
u=u*(50*n*10)/1000;


%% US Tax and Benefits System

for i=1:N
    % Defining taxable income
    taxable(i)=max(0,(d(i,3)-exempt));
    % Computing Federal taxes
    if taxable(i)>0.001 & taxable(i)<=inc1
       tax(i)=m1*taxable(i);
    elseif taxable(i)>inc1 & taxable(i)<=inc2
       tax(i)=m2*taxable(i);
    elseif taxable(i)>inc2 & taxable(i)<=inc3
       tax(i)=m3*taxable(i);
    elseif taxable(i)>inc3 & taxable(i)<=inc4
       tax(i)=m4*taxable(i);
    elseif taxable(i)>inc4 & taxable(i)<=inc5
       tax(i)=m5*taxable(i);
    elseif taxable(i)>inc5
       tax(i)=m6*taxable(i);
    else
       tax(i)=0;
    end
    % Computing Social Security tax
    ss(i)=min(ssrate*ssbase,ssrate*d(i,3));
    % Computing EITC benefits - Refundable tax credit
    if d(i,3)>0.001 & d(i,3)<eitceli 
        eitc(i)=min(eitcmax,eitcin*d(i,3));
    elseif d(i,3)>=eitceli & d(i,3)<eitcinc
        eitc(i)=min(eitcmax,(eitcmax-eitcout*(d(i,3)-eitceli)));
    else 
        eitc(i)=0;
    end
    % Computing DCTC benefits - Non-refundable tax credit
    if d(i,3)>0.001 & d(i,3)<=dctcinc1
       dctc(i)=min(tax(i),min(dctcmax,dctcrate1*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc1 & d(i,3)<=dctcinc2
       dctc(i)=min((i),min(dctcmax,dctcrate2*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc2 & d(i,3)<=dctcinc3
       dctc(i)=min(tax(i),min(dctcmax,dctcrate3*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc3 & d(i,3)<=dctcinc4
       dctc(i)=min(tax(i),min(dctcmax,dctcrate4*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc4 & d(i,3)<=dctcinc5
       dctc(i)=min(tax(i),min(dctcmax,dctcrate5*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc5 & d(i,3)<=dctcinc6
       dctc(i)=min(tax(i),min(dctcmax,dctcrate6*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc6 & d(i,3)<=dctcinc7
       dctc(i)=min(tax(i),min(dctcmax,dctcrate7*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc7 & d(i,3)<=dctcinc8
       dctc(i)=min(tax(i),min(dctcmax,dctcrate8*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc8 & d(i,3)<=dctcinc9
       dctc(i)=min(tax(i),min(dctcmax,dctcrate9*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc9 & d(i,3)<=dctcinc10
       dctc(i)=min(tax(i),min(dctcmax,dctcrate10*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc10 & d(i,3)<=dctcinc11
       dctc(i)=min(tax(i),min(dctcmax,dctcrate11*w*(1-d(i,2))));    
    elseif d(i,3)>dctcinc11 & d(i,3)<=dctcinc12
       dctc(i)=min(tax(i),min(dctcmax,dctcrate12*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc12 & d(i,3)<=dctcinc13
       dctc(i)=min(tax(i),min(dctcmax,dctcrate13*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc13 & d(i,3)<=dctcinc14
       dctc(i)=min(tax(i),min(dctcmax,dctcrate14*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc14 & d(i,3)<=dctcinc15
       dctc(i)=min(tax(i),min(dctcmax,dctcrate15*w*(1-d(i,2))));
    elseif d(i,3)>dctcinc15
       dctc(i)=min(tax(i),min(dctcmax,dctcrate16*w*(1-d(i,2))));
    else
       dctc(i)=0;
    end
    % Computing CCDF benefits   
    if d(i,3)>0.001 & d(i,3)<=ccdfinc1
       ccdf(i)=ccdfrate1*ccdfsub*w*(1-d(i,2));
    elseif d(i,3)>ccdfinc1 & d(i,3)<ccdfinc2
       ccdf(i)=ccdfrate2*ccdfsub*w*(1-d(i,2));
    elseif d(i,3)>ccdfinc2 & d(i,3)<ccdfinc3
       ccdf(i)=ccdfrate3*ccdfsub*w*(1-d(i,2));
    else
       ccdf(i)=0;
    end 
    % Computing Unemployment benefits
    if d(i,3)<0.001
        tax(i)=-unem;
    end
    % Consumption  
    c(i)=d(i,1);
end
   
asub(1)=0;
for i=2:N
    formal(i)=w*max(0,(1-d(i,2)));
    if d(i,3)>0.001
        asub(i)=(dctc(i)+ccdf(i))/formal(i);
    else
        asub(i)=0;
    end
end

earnings=d(:,3)*10*50*n/1000;
consumption=c(:)*10*50*n/1000;

d0=mat2str(d)
earnings0=mat2str(earnings)                                                 % Earnings in $000
care0=mat2str(d(:,2))                                                       % Care time out of 1 unit
consumption0=mat2str(consumption)                                           % Consumption in $000
G0=([p (1-p)*pz']*(((dctc+ccdf)-(tax+ss-eitc))*10*50*n/1000)')              % Parameter M in government budget constraint
u0=mat2str(u)                                                               % Utility              

save 'LogActual.mat'

beep

