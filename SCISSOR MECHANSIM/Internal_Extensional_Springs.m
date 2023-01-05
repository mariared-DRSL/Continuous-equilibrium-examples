function [results] = Internal_Extensional_Springs(Psi)

% Get kinematics and potential energy due to gravity (PEgrav)
Gravity = zeros(91,length((Psi)));
for m = 1:length(Psi)

    [Phi,ThetaA,ThetaB,ThetaC,ThetaD,Lengths2,Lengths1,~,~,PEgrav] = Get_Kinematics_Scissor(Psi(m));

    Gravity(:,m) = PEgrav;  

end

    % Find rest angles and stiffnesses that optimize for continuous equilibrium
    [L02,L01,k2,k1,history,exitflag,lambda] = FindRest_Internal_Extensional_Springs(Lengths2,Lengths1,Gravity);

for i = 1:length(Psi)
    
    % Calculate PE from extensional springs: 1/2*k*(L-L0)^2
    PE_2 = (1/2)*k2*(Lengths2-L02).^2;
    PE_1 = (1/2)*k1*(Lengths1-L01).^2;
    
    % Sum all PE contributions
    PE_T = Gravity(:,i) + PE_1' + PE_2';
    
    % Calculate sum(abs(diff(PE)))
    SAD(i) = sum(abs(diff(PE_T)));
    SADgrav(i) = sum(abs(diff(Gravity(:,i))));
    normSAD(i) = SAD(i)/SADgrav(i);

    % Plot potential energy breakdown for current Psi
    Plot_Internal_Extensional(Phi,PE_1',PE_2',Gravity(:,i))

end

results.L01 = L01;
results.L02 = L02;
results.k1 = k1;
results.k2 = k2;
results.SAD = SAD;
results.SADgrav = SADgrav;
results.normSAD = normSAD;


end