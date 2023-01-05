%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%---------------------- Watt's Linkage --------------------------%%%
%%%---------------------- Maria Redoutey --------------------------%%%
%%%--------------------- 22 February 2021 -------------------------%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Phi,ThetaA,ThetaB,ThetaC,ThetaD,PEgrav] = Get_Kinematics_Watts(Psi)

    % Range of angle Phi
    Min_Input_Ang = 145;  
    Max_Input_Ang = 215; 
    Phi = [Min_Input_Ang:1:Max_Input_Ang]*pi/180;

    % Bar Lengths
    L_AB = 0.3; L_BC = 0.3; L_CD = 0.3; L_DA = 0.6;

    % Baseline (zero PE due to gravity)
    Base = 1;

    % Pin Support Coordinates
    A = [0 L_BC+Base];
    D = [L_DA Base];
    
    syms Cx Cy
    
    for i = 1:length(Phi)        
    
        B = A + [L_AB*cos(pi-Phi(i)) L_AB*sin(pi-Phi(i))];

        eqn1 = (B(1)-Cx)^2 + (B(2)-Cy)^2 == L_BC^2;
        eqn2 = (D(1)-Cx)^2 + (D(2)-Cy)^2 == L_CD^2;

        [sol] = solve(eqn1,eqn2); 

        C = [double(sol.Cx(1)) double(sol.Cy(1))];
        
        P = (B+C)/2;

        if imag(C)
            disp('Bar Lengths Incompatible with Angle Range!!')
            return
        end
      
        coords = [A;B;C;D];
        
        R = [cos(Psi) -sin(Psi);
             sin(Psi) cos(Psi)];

        pts = [coords(:,1)-A(1) coords(:,2)-A(2)];
        pts2 = R*transpose(pts);
        coords = transpose([pts2(1,:)+A(1); pts2(2,:)+A(2)]);

        mass_coeff = [0.5*L_AB; 0.5*L_AB+0.5*L_BC; 0.5*L_BC+0.5*L_CD; 0.5*L_CD];
        PEgrav(i) = sum(mass_coeff.*9.81.*coords(:,2));

        [DAng,BAng,CAng] = GetAnglesWatts(coords,Psi); 
        ThetaD(i) = DAng; ThetaB(i) = BAng; ThetaC(i) = CAng; 
        
    end
ThetaA = Phi;
ThetaA = round(ThetaA,4); ThetaB = round(ThetaB,4); ThetaC = round(ThetaC,4); ThetaD = round(ThetaD,4);
end 