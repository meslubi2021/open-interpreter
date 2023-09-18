function [c ceq]=mycon(x)

global w z pz Nz N p theta gamma G n Au1 rho

%% Incentive compatibility constraints
% Global Upward Constraints with Inequality
D(1)=0;  
% for r=2:N-1
%     for s=1:N-2
%         if r+s<N+1 
%             D(N*r-2*N+s)=((x(r+s,1)-(1/theta)*((((x(r+s,3)/z(r-1))+x(r+s,2))^(1+gamma))/(1+gamma))))-((x(r,1)-(1/theta)*((((x(r,3)/z(r-1))+x(r,2))^(1+gamma))/(1+gamma))));
%         else
%             D(N*r-2*N+s)=0;
%         end
%     end  
% end

% LUIC
for r=2:N-1
    for s=1:1
        if r+s<N+1 
            D(N*r-2*N+s)=((x(r+s,1)-(1/theta)*((((x(r+s,3)/z(r-1))+x(r+s,2))^(1+gamma))/(1+gamma))))-((x(r,1)-(1/theta)*((((x(r,3)/z(r-1))+x(r,2))^(1+gamma))/(1+gamma))));
        else
            D(N*r-2*N+s)=0;
        end
    end  
end

% Gobal Downward Constraints with Inequality
O(1)=0;
for r=2:N
    for s=1:N-1
        if r+s<N+2
            O(N*r-2*N+s)=((x(r-1,1)-(1/theta)*((((x(r-1,3)/z(r+s-2))+x(r-1,2))^(1+gamma))/(1+gamma))))-((x(r+s-1,1)-(1/theta)*((((x(r+s-1,3)/z(r+s-2))+x(r+s-1,2))^(1+gamma))/(1+gamma))));
        else
            O(N*r-2*N+s)=0;
        end
    end  
end

% Pooling among unemployed with Equality 
L(1)=0;
% for r=1:N-1
%     if x(r,3)<0.0001 & x(r+1,3)<0.0001
%         L(r+1)=x(r,2)-x(r+1,2);                                           
%     else
%         L(r+1)=0;
%     end
% end

%% Non-negative argument inside log and non negative h and y
% E(1)=(1/theta)*(((x(1,2))^(1+gamma))/(1+gamma))-x(1,1);
for r=2:N
%     E(r)=(1/theta)*((((x(r,3)/z(r-1))+x(r,2))^(1+gamma))/(1+gamma))-x(r,1);
    E(N+r)=-x(r,2);
    E(2*N+r)=-x(r,3);
end
E(N+1)=-x(1,2);

%% Pareto improvement
for r=1:1
    F(r)=-(x(r,1)-(1/theta)*(((x(r,2))^(1+gamma))/(1+gamma))-(Au1(r)/((10*n*50)/1000)));
end
for r=2:N
    F(r)=-(x(r,1)-(1/theta)*((((x(r,3)/z(r-1))+x(r,2))^(1+gamma))/(1+gamma))-(Au1(r)/((10*n*50)/1000)));
end

c=[D(:);E(:);O(:);F(:)];


%% Feasibility constraint

% Unlucky must have zero production
K(1)=-x(1,3);

for r=1:1
    A(r)=p*(x(r,1)+w*max(0,(1-x(r,2))));
end
for r=2:N
    A(r)=(1-p)*pz(r-1)*(x(r,1)+w*max(0,(1-x(r,2)))-x(r,3));
end

vec=ones(N,1);
B=A*vec-G;

ceq=[B;K(:);L(:)];

