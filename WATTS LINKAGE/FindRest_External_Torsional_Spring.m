%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%--------------- Miura-ori Cell: Zero Stiffness -----------------%%%
%%%---------------------- Maria Redoutey --------------------------%%%
%%%---------------------- 10 March 2021 ---------------------------%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [mer,k,history,exitflag,lambda] = FindRest_ExtSpring_Watts(Theta,Grav,ang) 

% Design variables: [alpha, ktheta]

% Linear constraints
A = []; b = []; Aeq = []; beq = []; 

% Lower and upper bounds for design variables
lb = [0 0]; ub = [2*pi 100];
% lb = [min(Theta),0]; ub = [max(Theta),Inf];

% Initial values for design variables
r0 = [pi/2 1]; 

Theta2 = repmat(Theta,size(Grav,2),1);

% Objective function - sum(abs(diff(PE)))
ObjFun = @(r)mean(sum(abs(diff(transpose((1/2)*r(2)*(Theta2-transpose(r(1)+ang)).^2 + transpose(Grav))))));

% Call Optimization
[rest,~,exitflag,lambda,history,~] = runfmincon(ObjFun,r0,A,b,Aeq,beq,lb,ub);
mer = rest(1); k = rest(2);

end 

function [rest,fval,exitflag,lambda,history,searchdir] = runfmincon(PEtot,r0,A,b,Aeq,beq,lb,ub)
 
history.x = [];
history.fval = [];
searchdir = [];

% history is a struct with two values: fval and x
% history.x is a n-by-6 matrix where n is the number of optimization steps
% The columns of history.x correspond to variables being optimized: 
% [alphaA, alphaB, alphaC, alphaD, LAC, LBD, kthetaA, kthetaB, kthetaC, kthetaD, kAC, kBD]
 
% Call optimization
options = optimoptions(@fmincon,'OutputFcn',@outfun,'Display','none','Algorithm','interior-point','FiniteDifferenceStepSize',1e-6,'MaxFunctionEvaluations',12000,'MaxIterations',2000,'StepTolerance',1e-6); 
[rest,fval,exitflag,~,lambda] = fmincon(PEtot,r0,A,b,Aeq,beq,lb,ub,[],options);
 
 function stop = outfun(x,optimValues,state)
     stop = false;
     switch state
         case 'init'
        
         case 'iter'
                history.fval = [history.fval; optimValues.fval];
                history.x = [history.x; x];
         case 'done'
           
         otherwise
     end
 end

end