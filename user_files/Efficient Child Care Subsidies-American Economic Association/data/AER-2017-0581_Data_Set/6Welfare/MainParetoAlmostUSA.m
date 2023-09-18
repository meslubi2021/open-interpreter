
%% Computing welfare gains in Table B5 Column (8)

clc
clear all

global p pz d 

y0=1;

%% Optimal vs USA

y=fsolve(@FParetoAlmostUSA,y0);

CE=y*100

