
%% Computing welfare gains in Table B5 Column (1)

clc
clear all

global p pz d 

y0=1;

%% Optimal vs USA

y=fsolve(@FBaseUSA,y0);

CE=y*100
