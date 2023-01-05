function [results] = External_Torsional_Spring(Psi)

% Get kinematics and potential energy due to gravity (PEgrav)
Gravity = zeros(71,length((Psi)));
for m = 1:length(Psi)

    [Phi,ThetaA,ThetaB,ThetaC,ThetaD,PEgrav] = Get_Kinematics_Watts(Psi(m));

    Gravity(:,m) = PEgrav;  
    
end

    % Find rest angles and stiffnesses that optimize for continuous equilibrium
    [alphaE,kE,history,exitflag,lambda] = FindRest_External_Torsional_Spring(Phi,Gravity,Psi); 

for i = 1:length(Psi)
    
    % Calculate PE from torsional spring j: 1/2*k_j*(theta_j-alpha_j)^2
    PE_E = (1/2)*kE*(Phi-(alphaE+Psi(i))).^2; 
    
    % Sum all PE contributions
    PE_T = Gravity(:,i) + PE_E';
    
    % Calculate sum(abs(diff(PE)))
    SAD(i) = sum(abs(diff(PE_T)));
    SADgrav(i) = sum(abs(diff(Gravity(:,i))));
    normSAD(i) = SAD(i)/SADgrav(i);
    
    % Plot potential energy breakdown for current Psi
    Plot_External_Torsional(Phi,PE_E',Gravity(:,i))

end

results.aE = alphaE;
results.kE = kE;
results.SAD = SAD;
results.SADgrav = SADgrav;
results.normSAD = normSAD;

end
