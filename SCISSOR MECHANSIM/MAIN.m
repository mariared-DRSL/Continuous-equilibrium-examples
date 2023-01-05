%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%----------- Scissor Mechanism: Continuous Equilibrium ----------%%%
%%%-------------- Maria Redoutey and Evgueni Filipov --------------%%%
%%%--------------------------- doi: -------------------------------%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; 
clear; clc 

% Orientation angle Psi
Psi = [0 45 90]*pi/180;

%% Internal_Torsional_Springs
% [results] = Internal_Torsional_Springs(Psi);

%% External Torsional Spring
% [results] = External_Torsional_Spring(Psi);

%% Internal_Extensional_Springs
[results] = Internal_Extensional_Springs(Psi);

%% External Extensional Spring
% [results] = External_Extensional_Spring(Psi);




