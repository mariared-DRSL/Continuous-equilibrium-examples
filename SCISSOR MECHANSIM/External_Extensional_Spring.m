function [results] = External_Extensional_Spring(Psi)

% Get kinematics and potential energy due to gravity (PEgrav)
Gravity = zeros(91,length((Psi)));
for m = 1:length(Psi)

    [Phi,ThetaA,ThetaB,ThetaC,ThetaD,Lengths3,x,y,PEgrav] = Get_Kinematics_Scissor(Psi(m));

    Gravity(:,m) = PEgrav;  
    storex(:,m) = x;
    storey(:,m) = y;

end

    % Find Optimal Rest Values 
    [L03,k3,X,Y,history,exitflag,lambda] = FindRest_External_Extensional_Spring(storex,storey,Gravity);

for i = 1:length(Psi)
    
    % Calculate PE from extensional springs: 1/2*ktheta*(theta-alpha)^2
    PE_3 = (1/2)*k3*(sqrt((storex(:,i)-X).^2 + (storey(:,i)-Y).^2)-L03).^2;
    
    % Sum all PE contributions
    PE_T = Gravity(:,i) + PE_3;
    
    % Calculate sum(abs(diff(PE)))
    SAD(i) = sum(abs(diff(PE_T)));
    SADgrav(i) = sum(abs(diff(Gravity(:,i))));
    normSAD(i) = SAD(i)/SADgrav(i);

    Plot_External_Extensional(Phi,PE_3,Gravity(:,i))
    
end

results.L03 = L03;
results.k3 = k3;
results.X = X;
results.Y = Y;
results.SAD = SAD;
results.SADgrav = SADgrav;
results.normSAD = normSAD;

end
  