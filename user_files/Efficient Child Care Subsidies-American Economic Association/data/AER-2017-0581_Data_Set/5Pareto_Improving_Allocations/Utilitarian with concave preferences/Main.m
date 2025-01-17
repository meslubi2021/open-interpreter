
%% Pareto Improving Allocations
% Baseline Pareto Improving Specification (9) in Table B4


clc
clear all

% Actual utility under US tax and benefit system   
load ('..\..\3Calibration_M\Concave\LogActual.mat') 
Au1=u;

global w z pz Nz N p theta gamma G n Au1

w=0.51;                                                     % Cost of formal child care based on 2010 average child care cost
z=0.1*[2.40 3.75 4.08 4.32 4.54 4.72 4.85 4.97 5.08 5.19 5.29 5.43 5.54 5.63 5.76 5.88 6 6.13 6.23 6.36 6.5 6.66 6.8 7.02 7.21 7.34 7.52 7.71 8.01 8.33 8.69 9 9.37 9.61 10 10.31 10.83 11.53 12.01 12.5 13.46 14 14.57 15.71 16.82 18.51 20 22.36 25.64 32.21];
                                                            % Market productivity type (normalised by dividing by 10)
Nz=50;
N=51;

%% e=24 ; gamma=1 ; w=0.51                                    
n=24;                                                       % Normalisation
gamma=1;                                                    % Effort felicity parameter
G=(5256)/(10*50*n);                                         % Government generosity when w=0.51
theta=1.39;                                                 % Effort cost type types

%% Empirical distributions
pz=0.02*ones(Nz,1);                                         % Distribution of z based on 2010 March CPS z distribution
p=0.11;                                                     % Probability of being unlucky

%% Optimisation

options=optimset('LargeScale','on','MaxFunEvals',10000000,'Display','Iter','MaxIter',1000000,'TolCon',1e-6,'TolX',1e-6);

% Initial values
init=0.5*ones(N,3);
% lb=1e-5*ones(N,3);
ub=100*ones(N,3);
for i=1:N
    ub(i,2)=1;
end

% e=24 ; gamma=1 ; sigma=2; w=0.51 ; DIC & LUIC
init=[0.48877582812462 0.99998193992252 3.41417012165062e-09;0.48881494374962 0.999888066956273 2.23674863779298e-05;0.491019646524186 0.999885018834175 0.00232313828149315;0.508500683894582 0.999856643763692 0.0215849414354718;0.523611809533905 0.999818297117699 0.0380312428948312;0.539464305898748 0.999755124177807 0.0551122027653376;0.553931017259365 0.999649073378957 0.0704675929167841;0.563737031414777 0.999492589134254 0.0807584661510161;0.572767917227874 0.999137613367619 0.0902827998860668;0.581287107542097 0.997683256538496 0.0997894131836782;0.584228674883137 0.0320467961447738 0.60397845915215;0.594913412918707 0.00183961485273247 0.63118189854272;0.614199718929574 0.000668393227663781 0.65213942241599;0.629404058600304 0.000445903776801454 0.668014937293595;0.641130383211143 0.000353647793816671 0.680069070773345;0.658315663980539 0.000272533665019232 0.697688841672598;0.673103899178465 0.000228172046791789 0.712452367648798;0.689761820269371 0.000192103317563688 0.728832613605744;0.708553554599877 0.000164420341573515 0.747107145186111;0.722075367915404 0.000148517411129952 0.760239091751396;0.743485015903634 0.000128816571785851 0.780726591545915;0.765796616566884 0.000113594158040727 0.801759307816203;0.79329727462452 9.90121401708323e-05 0.827217518114034;0.812354504350845 9.12281496201516e-05 0.844738736743083;0.865002605472726 7.44520713888492e-05 0.891254517400024;0.888900911272048 6.90365141982474e-05 0.911969769088422;0.895019612654141 6.79968343570236e-05 0.917395352015183;0.942429233097802 5.9135694712767e-05 0.95861308163048;0.98023569742883 5.3716236040554e-05 0.990347357758493;1.04146074527487 4.67387556141561e-05 1.03967719308179;1.05047851921432 4.59821756897532e-05 1.04705192694723;1.05097347226473 4.64711525414819e-05 1.04750858790987;1.06109234782476 4.55332763623214e-05 1.05742770732043;1.07772185473425 4.38179750628923e-05 1.07472484707552;1.10658368260597 4.12654489776153e-05 1.10582406349562;1.14842303405357 3.79777214582309e-05 1.15149943139316;1.19039346578167 3.52063584320941e-05 1.19664840804563;1.25693820174847 3.1563222007942e-05 1.26854568483186;1.32069952900725 2.86522925639925e-05 1.33857566297838;1.33934358017285 2.78284059706421e-05 1.35937107147535;1.34316549025982 2.74021053487945e-05 1.36389852066181;1.370225919142 2.59790789930356e-05 1.40022651146279;1.37043872820295 2.5560722698714e-05 1.40051726291661;1.37061604705746 2.50897535078829e-05 1.40078609875625;1.42964707260058 2.27975829518579e-05 1.50050066177769;1.47641212600757 2.08972196846034e-05 1.58260454629192;1.63266512574178 1.7378903806952e-05 1.86085953079051;1.71607718539336 1.56745880913815e-05 2.00420817024135;1.95189244644931 1.27533539597407e-05 2.40965555608994;2.21293400066516 1.04173068960284e-05 2.84611338055713;3.27421296292666 6.52804599767975e-06 4.40446303303876];

x=fmincon(@(x) V(x),init,[],[],[],[],[],ub,@(x) mycon(x),options);

beep

%% Expost check of LDIC binding and UIC satisfied
% LDIC
for r=1:N-1
    K(r)=((log(x(r,1))-(1/theta)*((((x(r,3)/z(r))+x(r,2))^(1+gamma))/(1+gamma))))-((log(x(r+1,1))-(1/theta)*((((x(r+1,3)/z(r))+x(r+1,2))^(1+gamma))/(1+gamma))));
end 
nobind1=sum(K<-0.01)
nobind2=sum(K>0.01)
% UIC
for r=2:N-1
    for s=1:N-2
        if r+s<N+1 & x(r+s,1)+1>0
            D(N*r-2*N+s)=((log(x(r+s,1))-(1/theta)*((((x(r+s,3)/z(r-1))+x(r+s,2))^(1+gamma))/(1+gamma))))-((log(x(r,1))-(1/theta)*((((x(r,3)/z(r-1))+x(r,2))^(1+gamma))/(1+gamma))));
        else
            D(N*r-2*N+s)=0;
        end
    end  
end
bind=sum(D>0.01)

%% Optimal Allocations

wage=10*[0 z];
earnings=10*n*50*x(:,3)/1000;
consumption=10*n*50*x(:,1)/1000;
care=x(:,2);
formal=10*n*50*w*(1-x(:,2))/1000;

wedge(1)=1-(1/w)*((1/theta)*((x(1,2))^gamma));
for r=2:N
    if x(r,3)>0.08
        wedge(r)=1-(1/z(r-1))*((1/theta)*(((x(r,3)/z(r-1))+x(r,2))^gamma)*x(r,1));
    else 
        wedge(r)=1-(1/w)*((1/theta)*((x(r,2))^gamma))*x(r,1);
    end
end             
                
for r=1:N
    if care(r,1)<0.99 & x(r,3)>0.08
        subsidy(r)=min(1,max(0,(1-((1/w)*((1/theta)*((x(r,3)/z(50))+x(r,2))^gamma)*x(r,1)))));
    else 
        subsidy(r)=0;
    end
end

for r=1:1
    val(r)=log(x(r,1))-(1/theta)*(((x(r,2))^(1+gamma))/(1+gamma));
    u(r)=log(x(r,1))-(1/theta)*(((x(r,2))^(1+gamma))/(1+gamma));
end
for r=2:N
    val(r)=log(x(r,1))-(1/theta)*((((x(r,3)/z(r-1))+x(r,2))^(1+gamma))/(1+gamma));
    u(r)=log(x(r,1))-(1/theta)*((((x(r,3)/z(r-1))+x(r,2))^(1+gamma))/(1+gamma));
end

u=u*(10*n*50)/1000;

x
init0=mat2str(x)
earnings0=mat2str(earnings)
care0=mat2str(care)
consumption0=mat2str(consumption)
wedge0=mat2str(wedge)
subsidy0=mat2str(subsidy)
u0=mat2str(u)
val0=mat2str(val)

nowork=x(:,3)<0.2;                                                          % Those who receive zero subsidies                                                       
nowork1=x(:,3)<0.08;                                                        % No. unemployed 
firstwork=sum(nowork)+1;                                                    % Index of first z employed 
earn=earnings(firstwork:N);
sub=subsidy(firstwork:N);
earn0=mat2str(earn)
sub0=mat2str(sub)

save ParetoLog.mat

beep