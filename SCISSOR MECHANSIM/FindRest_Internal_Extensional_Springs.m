%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%--------------- Miura-ori Cell: Zero Stiffness -----------------%%%
%%%---------------------- Maria Redoutey --------------------------%%%
%%%---------------------- 10 March 2021 ---------------------------%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [r1,r2,r3,r4,history,exitflag,lambda] = FindRest_Extensional_InternalSprings_Scissor(Lengths,Lengths2,Grav) 

% Design variables: [L01, L02, k1, k2]

% Linear constraints
A = []; b = []; Aeq = []; beq = []; 

% Lower and upper bounds for design variables
lb = [0,0,0,0]; ub = [Inf,Inf,Inf,Inf];


% Initial values for design variables
r0 = [1,1,10,10]; 

% Objective function - sum(abs(diff(PE)))
ObjFun = @(r)mean(sum(abs(diff(transpose((1/2)*r(3)*(Lengths-r(1)).^2 + (1/2)*r(4)*(Lengths2-r(2)).^2 + transpose(Grav))))));

% Call Optimization
[rest,~,exitflag,lambda,history,~] = runfmincon(ObjFun,r0,A,b,Aeq,beq,lb,ub);
r1 = rest(1); r2 = rest(2); r3 = rest(3); r4 = rest(4);

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