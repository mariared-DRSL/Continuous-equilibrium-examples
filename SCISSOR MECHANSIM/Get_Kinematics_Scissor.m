function [PHI,ThetaA,ThetaB,ThetaC,ThetaD,LengthsSpan,LengthsUnit,x,y,PEgrav] = Get_Kinematics_Scissor(Psi)

L = 0.3; % bar length

n = 2; % number of units 

rho = 1; % mass density of bars [kg/m]

gravmult = rho*L; % mass of each bar [kg/m]*[m] = [kg]

MinPHI = 0;
MaxPHI = 90;

PHI = [MaxPHI:-1:MinPHI]*pi/180;

for i = 1:length(PHI)
    
    A = [0 0];
    
    B = [0 L*sin(PHI(i))];
    
    C = [L*cos(PHI(i)) 0];
    
    D = [L*cos(PHI(i)) L*sin(PHI(i))];
    
    coords1 = [(1:n)*C(1); (1:n)*D(1)]; coords1 = coords1(:)';
    
    coords2 = [ones(1,n)*C(2); ones(1,n)*D(2)]; coords2 = coords2(:)';
    
    coords = [A;B;transpose([coords1; coords2])];
        
    % PE due to gravity: mass*gravity*height    
    mass_coeff = gravmult.*[0.5; 0.5; ones((n-1)*2,1); 0.5; 0.5];
    
    R = [cos(Psi) -sin(Psi);
         sin(Psi) cos(Psi)];

    coords = R*transpose(coords); coords = transpose(coords);
    
    PEgrav(i) = sum(mass_coeff.*9.81.*coords(:,2));
    
    ThetaA(i) = 2*PHI(i);
    ThetaB(i) = ThetaA(i);
    ThetaC(i) = pi - 2*PHI(i);
    ThetaD(i) = ThetaC(i);
    
    LengthsSpan(:,i) = sqrt((coords(1,1)-coords(end,1)).^2 + (coords(1,2)-coords(end,2)).^2);
    LengthsUnit(:,i) = sqrt((coords(3,1)-coords(4,1)).^2 + (coords(3,2)-coords(4,2)).^2);
    x(:,i) = coords(end,1);
    y(:,i) = coords(end,2);
                
end 

end