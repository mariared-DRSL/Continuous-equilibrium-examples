%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%---------------------- Watt's Linkage --------------------------%%%
%%%---------------------- Maria Redoutey --------------------------%%%
%%%--------------------- 22 February 2021 -------------------------%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ThetaA,ThetaB,ThetaC,ThetaD,Lengths,PEgrav,savecoords] = GetGeo_Watts_ReOrient_2(ang)

    % Range of Crank Angle
    Min_Input_Ang = 145; %145 
    Max_Input_Ang = 215; %215
    ThetaA = [Min_Input_Ang:1:Max_Input_Ang]*pi/180;

    % Bar Lengths
    L_AB = 0.3; L_BC = 0.3; L_CD = 0.3; L_DA = 0.6;

    % Baseline (zero PE due to gravity)
    Base = 1;

    % Pin Support Coordinates
    A = [0 L_BC+Base];
    D = [L_DA Base];
    
    syms Cx Cy
    
    for i = 1:length(ThetaA)        
    
        B = A + [L_AB*cos(pi-ThetaA(i)) L_AB*sin(pi-ThetaA(i))];

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
        
        R = [cos(ang) -sin(ang);
             sin(ang) cos(ang)];

        pts = [coords(:,1)-A(1) coords(:,2)-A(2)];
        pts2 = R*transpose(pts);
        coords = transpose([pts2(1,:)+A(1); pts2(2,:)+A(2)]);
        
        savecoords(i,:) = [coords(1,:) coords(2,:) coords(3,:) coords(4,:)];

%         if i == 1
%             figure()
%             plot(coords(:,1),coords(:,2),'ko-')
%             hold on
%             plot(coords(:,1),[0 0 0 0],'b')
%             hold on
% %             plot(P(1),P(2),'c*')
% %             hold on
%             axis equal; axis off;
%         elseif i == 40
%             figure()
%             plot(coords(:,1),coords(:,2),'ko-')
%             axis equal; axis off;
%         elseif i == 80
%             figure()
%             plot(coords(:,1),coords(:,2),'ko-')
%             axis equal; axis off;
%         elseif i == 120
%             figure()
%             plot(coords(:,1),coords(:,2),'ko-')
%             axis equal; axis off;
%         elseif i == 140
%             figure()
%             plot(coords(:,1),coords(:,2),'ko-')
%             axis equal; axis off;
%         elseif i == length(ThetaA)
%             figure()
%             plot(coords(:,1),coords(:,2),'ko-')
%             axis equal; axis off;
%         end

        mass_coeff = [0.5*L_AB; 0.5*L_AB+0.5*L_BC; 0.5*L_BC+0.5*L_CD; 0.5*L_CD];
        PEgrav(i) = sum(mass_coeff.*9.81.*coords(:,2));

        [DAng,BAng,CAng] = GetAnglesWatts(coords,ang); 
        ThetaD(i) = DAng; ThetaB(i) = BAng; ThetaC(i) = CAng; %ThetaD(i) = ThetaA(i);
        
        Lengths(i,:) = [sqrt((A(1)-C(1))^2+(A(2)-C(2))^2), sqrt((B(1)-D(1))^2+(B(2)-D(2))^2)];

    end


end 