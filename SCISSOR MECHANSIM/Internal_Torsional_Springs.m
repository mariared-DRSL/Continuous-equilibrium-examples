function [results] = Internal_Torsional_Springs(Psi)

% Get kinematics and potential energy due to gravity (PEgrav)
Gravity = zeros(91,length((Psi)));
for m = 1:length(Psi)

    [Phi,ThetaA,ThetaB,ThetaC,ThetaD,~,~,~,~,PEgrav] = Get_Kinematics_Scissor(Psi(m));

    Gravity(:,m) = PEgrav;  

end

    % Find rest angles and stiffnesses that optimize for continuous equilibrium
    [as,ks,history,exitflag,lambda] = FindRest_Internal_Torsional_Springs(ThetaA,ThetaB,ThetaC,ThetaD,Gravity); 

for i = 1:length(Psi)
    
    % Calculate PE from torsional spring j: 1/2*k_j*(theta_j-alpha_j)^2
    PE_A = (1/2)*ks(1)*(ThetaA-(as(1))).^2;
    PE_B = (1/2)*ks(2)*(ThetaB-(as(2))).^2;
    PE_C = (1/2)*ks(3)*(ThetaC-(as(3))).^2;
    PE_D = (1/2)*ks(4)*(ThetaD-(as(4))).^2;
    
    % Sum all PE contributions
    PE_T = Gravity(:,i) + PE_A' + PE_B' + PE_C' + PE_D';
    
    % Calculate sum(abs(diff(PE_T)))
    SAD(i) = sum(abs(diff(PE_T)));
    SADgrav(i) = sum(abs(diff(Gravity(:,i))));
    normSAD(i) = SAD(i)/SADgrav(i);

    % Plot potential energy breakdown for current Psi
    Plot_Internal_Torsional(Phi,PE_A,PE_B,PE_C,PE_D,Gravity(:,i)')
end

results.aA = as(1);
results.aB = as(2);
results.aC = as(3);
results.aD = as(4);
results.kA = ks(1);
results.kB = ks(2);
results.kC = ks(3);
results.kD = ks(4);
results.SAD = SAD;
results.SADgrav = SADgrav;
results.normSAD = normSAD;

end
