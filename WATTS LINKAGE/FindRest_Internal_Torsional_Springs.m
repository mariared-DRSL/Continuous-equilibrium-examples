%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%--------------- Miura-ori Cell: Zero Stiffness -----------------%%%
%%%---------------------- Maria Redoutey --------------------------%%%
%%%---------------------- 10 March 2021 ---------------------------%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [as,ks,history,exitflag,lambda] = FindRest_Internal_Torsional_Springs(ThetaA,ThetaB,ThetaC,ThetaD,Grav) 

% Design variables: [alphaA, alphaB, alphaC, alphaD, kthetaA, kthetaB, kthetaC, kthetaD]

% Linear constraints
A = []; b = []; Aeq = []; beq = []; 

% Lower and upper bounds for design variables
% lb = [0 0 0 0 1 1 1 1]; ub = [2*pi 2*pi 2*pi 2*pi Inf Inf Inf Inf];
lb = [min(ThetaA),min(ThetaB),min(ThetaC),min(ThetaD),0,0,0,0]; ub = [max(ThetaA),max(ThetaB),max(ThetaC),max(ThetaD),Inf,Inf,Inf,Inf];


% Initial values for design variables
% r0 = [pi/2 pi/2 pi/2 pi/2 10 10 10 10]; 
r0 = [(max(ThetaA)-min(ThetaA))/2+min(ThetaA),(max(ThetaB)-min(ThetaB))/2+min(ThetaB),(max(ThetaC)-min(ThetaC))/2+min(ThetaC),(max(ThetaD)-min(ThetaD))/2+min(ThetaD),10,10,10,10]; 

ThetaA2 = repmat(ThetaA,size(Grav,2),1);
ThetaB2 = repmat(ThetaB,size(Grav,2),1);
ThetaC2 = repmat(ThetaC,size(Grav,2),1);
ThetaD2 = repmat(ThetaD,size(Grav,2),1);

% Objective function: sum(abs(diff(PE)))
ObjFun = @(r)mean(sum(abs(diff(transpose((1/2)*r(5)*(ThetaA2-transpose(r(1))).^2 + (1/2)*r(6)*(ThetaB2-transpose(r(2))).^2 + (1/2)*r(7)*(ThetaC2-transpose(r(3))).^2 + (1/2)*r(8)*(ThetaD2-transpose(r(4))).^2 + transpose(Grav))))));

% Call Optimization
[rest,~,exitflag,lambda,history,~] = runfmincon(ObjFun,r0,A,b,Aeq,beq,lb,ub);
aA = rest(1); aB = rest(2); aC = rest(3); aD = rest(4);
kA = rest(5); kB = rest(6); kC = rest(7); kD = rest(8);
as = [aA aB aC aD]; ks = [kA kB kC kD];

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