
%% Computing welfare gains in Table B5 Column (9)

clc
clear all

global p pz d 

y0=0.1;

%% Optimal vs USA

y=fsolve(@FLogPareto,y0);

CE=y*100

