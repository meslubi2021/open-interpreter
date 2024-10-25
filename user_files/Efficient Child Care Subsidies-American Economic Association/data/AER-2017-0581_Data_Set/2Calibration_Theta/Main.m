
%% Calibrating theta by matching mean labor supply predicted by our model with mean labor supply in CPS data
% For theta in Table B3
% Quasi-linear utility

clc
clear all

global w z pz N p theta gamma zu unem exempt m1 m2 m3 m4 m5 m6 inc1 inc2 inc3 inc4 inc5 ssrate ssbase eitceli eitcmax eitcin eitcout eitcinc dctcinc1 dctcinc2 dctcinc3 dctcinc4 dctcinc5 dctcinc6 dctcinc7 dctcinc8 dctcinc9 dctcinc10 dctcinc11 dctcinc12 dctcinc13 dctcinc14 dctcinc15 dctcrate1 dctcrate2 dctcrate3 dctcrate4 dctcrate5 dctcrate6 dctcrate7 dctcrate8 dctcrate9 dctcrate10 dctcrate11 dctcrate12 dctcrate13 dctcrate14 dctcrate15 dctcrate16 dctcmax ccdfsub ccdfinc1 ccdfinc2 ccdfinc3 ccdfrate1 ccdfrate2 ccdfrate3 cons

%%%%%%%%%%%%%%%%
%% Parameters %% 
%%%%%%%%%%%%%%%%

w=0.51;                                                     % Cost of formal child care based on 2010 average child care cost
                                                            % Market productivity type (normalised by dividing by 10)
z=0.1*[2.4 3.75 4.08 4.32 4.54 4.72 4.85 4.97 5.08 5.19 5.29 5.43 5.54 5.63 5.76 5.88 6 6.13 6.23 6.36 6.5 6.66 6.8 7.02 7.21 7.34 7.52 7.71 8.01 8.33 8.69 9 9.37 9.61 10 10.31 10.83 11.53 12.01 12.5 13.46 14 14.57 15.71 16.82 18.51 20 22.36 25.64 32.21];
cons=0;                                                     % In 1e34 specification need to scale up utility by a small number to avoid negative numbers in log social welfare

N=50;

%% e=24 ; gamma=1 ; w=0.51                                    
n=24;                                                       % Normalisation
gamma=1;                                                    % Effort felicity parameter
Nt=21;                                                      % Grid over theta
thetagrid=linspace(1.2,1.4,Nt);

%% e=34 ; gamma=1 ; w=0.51
% n=34;                                                       % Normalisation
% gamma=1;                                                    % Effort felicity parameter
% Nt=21;                                                      % Grid over theta
% thetagrid=linspace(0.8,1,Nt);
% cons=0.1;                                                   

%% e=24 ; gamma=1 ; w=0.64
% n=24;                                                       % Normalisation
% gamma=1;                                                    % Effort felicity parameter
% w=0.64;
% Nt=21;                                                      % Grid over theta
% thetagrid=linspace(1.2,1.4,Nt);

%% e=24 ; gamma=2 ; w=0.51
% n=24;                                                       % Normalisation
% gamma=2;                                                    % Effort felicity parameter
% Nt=21;                                                      % Grid over theta
% thetagrid=linspace(1.7,1.9,Nt);

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
initu=[0.177119365936452 0.611998756763434 1.88233585241107e-07;-0.0369597029484027 2.4388563517807e-06 0.222749613495859;0.0170665632110334 1.92704870603883e-06 0.263678731346333;0.0592182416530406 1.72143172389404e-06 0.29561187263473;0.0999737204236314 1.53779835463581e-06 0.326487281383991;0.134824677025003 1.36962335930721e-06 0.352889563404062;0.160837303030109 1.33532391105598e-06 0.372596106856609;0.185476245828538 1.26774327330391e-06 0.391261989559889;0.208590929129374 1.21179261668776e-06 0.40877312730092;0.232211583624 1.16085397392294e-06 0.426667575297177;0.254124071461362 1.11817374526072e-06 0.443267955574088;0.28550437115167 1.06309695901223e-06 0.467040923694388;0.310734583054026 9.99272968035985e-07 0.486154736594445;0.331754340462726 9.70470800591798e-07 0.50207880245957;0.362713972141637 9.31681896085856e-07 0.525533078609278;0.391919176693774 8.98564567425037e-07 0.547658241877192;0.421726813464277 4.34283155306973e-08 0.570239999310588;0.454697680108114 8.51695400150721e-07 0.595217725913315;0.480540942517847 8.28412390688777e-07 0.614795960849239;0.514762555541442 8.01030688138806e-07 0.640721432128352;0.55240671794151 7.7185067458501e-07 0.669239744292896;0.596432228244281 7.40932368142934e-07 0.702592411366153;0.63583278380556 7.16052789587776e-07 0.732441323333533;0.699403932709922 6.80413169759433e-07 0.780601293560564;0.755935097312147 6.52454083200057e-07 0.823427940420929;0.795484217076584 6.34617839309886e-07 0.853389399261619;0.851411340375081 6.11461302622923e-07 0.895758437868785;0.9119151640236 5.88878753542455e-07 0.941594673568785;1.0105200858893 5.56785784419737e-07 1.01629537999965;1.05572540899392 0.00548480743981084 1.04916666058369;1.06299809565303 0.027457319698722 1.04916666452584;1.06344617565368 0.0288110793332011 1.04916666401908;1.06399379034584 0.0304655438168651 1.04916666666438;1.05614679903836 0.00675790503873767 1.04916666672057;1.10435659467252 6.85844920593896e-07 1.10399967499737;1.16830484329003 6.53634289107859e-07 1.17350865247508;1.27995651795961 6.06447109853631e-07 1.29486918539581;1.35686798096892 0.028172026961878 1.36833332075885;1.34796999481912 0.00128906927951454 1.36833332511383;1.349778846794 0.00675402100715612 1.36833333340025;1.39853023496896 7.25648339017072e-07 1.54358207722302;1.48822980588222 6.87747710224562e-07 1.66991952263452;1.58674046972176 3.17729856987077e-08 1.80866731014814;1.79555392391915 5.68671134923459e-07 2.1027704609345;1.92677049803748 5.69329438130348e-07 2.41041345276863;2.01116869516977 0.00538885539360014 2.52555303040194;2.09513166972957 5.30503028295121e-07 2.68799966534234;2.43257858799643 4.71675190799771e-07 3.35979773874386;3.53645898835843 3.06902719049712e-07 5.28557293006217;5.41726456249693 1e-10 7.50723566545075];

% Those with employment opportunities
for i=1:N
    for r=1:Nt
        theta=thetagrid(r);
        zu=z(i);
        initU=initu(i,:);
        x(i,r,:)=fmincon(@V,initv,[],[],[],[],[],ubU,@myconV,options);
        v(i,r)=cons+x(i,r,1)-(1/theta)*(((x(i,r,2))^(1+gamma))/(1+gamma));
        d(i,r,:)=fmincon(@U,initU,[],[],[],[],[],ubU,@myconU,options);
        u(i,r)=cons+d(i,r,1)-(1/theta)*((((d(i,r,3)/zu)+d(i,r,2))^(1+gamma))/(1+gamma));
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

save '01ThetaBaseline.mat'
% save '02Theta1e34.mat'
% save '03ThetaHighw.mat'
% save '04ThetaUSGamma2.mat'

beep



