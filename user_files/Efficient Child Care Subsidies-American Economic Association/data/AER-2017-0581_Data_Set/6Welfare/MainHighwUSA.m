
%% Computing welfare gains in Table B5 Column (3)

clc
clear all

global p pz d cons

y0=1;

%% Optimalline vs USA

y=fsolve(@FHighwUSA,y0);

CE=y*100
