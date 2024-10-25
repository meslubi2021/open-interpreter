%% Optimal Allocations
% Log(c) specification (6) in Table B4

clc
clear all

global w z pz Nz N p theta gamma G 

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

options=optimset('LargeScale','on','MaxFunEvals',10000000,'Display','Iter','MaxIter',1000000,'TolCon',1e-7,'TolX',1e-7);

% Initial values
init=0.5*ones(N,3);
% lb=1e-5*ones(N,3);
ub=100*ones(N,3);
for i=1:N
    ub(i,2)=1;
end

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

wedge(1)=1-(1/w)*((1/theta)*((x(1,2))^gamma)*x(1,1));
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
    u(r)=log(x(r,1))-(1/theta)*(((x(r,2))^(1+gamma))/(1+gamma));
end
for r=2:N
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

nowork=x(:,3)<0.08;                                                        % No. unemployed
firstwork=sum(nowork)+1;                                                   % Index of first z employed 
earn=earnings(firstwork:N);
sub=subsidy(firstwork:N);
earn0=mat2str(earn)
sub0=mat2str(sub)

save ConcaveLog.mat

beep
