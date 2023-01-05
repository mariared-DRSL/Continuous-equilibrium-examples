%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%------------ Watt's Linkage: Continuous Equilibrium ------------%%%
%%%-------------- Maria Redoutey and Evgueni Filipov --------------%%%
%%%--------------------------- doi: -------------------------------%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

This code package contains the optimization framework for designing a Watt's Linkage to have continuous equilibrium properties. Details about the framework can be found in our publication 'Designing continuous equilibrium structures that counteract gravity in any orientation' (doi:) 

-----------------------------------------------------------------------
In file 'MAIN_WattsLinkage':

INPUT: orientation angle (or range of angles) 'Psi' 

Uncomment desired spring type (Internal torsional or external torsional)

OUTPUT: 'results' struct contains optimized spring properties (stiffnesses and rest angles/rest lengths) for all springs and measure of fluctuation of the total potential energy curve ('SAD'), fluctuation in the potential energy curve due to gravity ('SADgrav') and normalized fluctuation ('normSAD')
