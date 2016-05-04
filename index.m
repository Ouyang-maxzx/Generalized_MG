clear;clc;



MG = MG_dataSetting();

%% Equality constraints:
%Power balance
MG = Eq_Power( MG );
%Indicator for L1: should meet the operation time intervals
MG = Eq_L1_flg( MG );
%Indicator for L2: should meet the operation time intervals
MG = Eq_L2_flg( MG );
%Indicator for L2: Additional flags ---- starting and ending intervals
MG = Eq_L2_continuous( MG );
MG = Eq_L2_s( MG );
MG = Eq_L2_e( MG );

%% Inequality constraints: A*x<=b
%Re-arrange the variables:
MG = reArrange_X( MG );

% ES SOC should be limited in a range wish upper and lower limits:
MG = Ineq_ES_SOC( MG );
MG = Ineq_ES_SOC_T( MG );

% additional constraints for binaries in UG, CL, ES, EV:
MG = Ineq_UG_in( MG );
MG = Ineq_UG_out( MG );
MG = Ineq_CL_in( MG );  %Particularly
MG = Ineq_CL_out( MG ); %Particularly
MG = Ineq_ES_in( MG );
MG = Ineq_ES_out( MG );
MG = Ineq_EV_in( MG );
MG = Ineq_EV_out( MG );

%% Inequality constraints: lb<=x<=ub
MG = Ineq_X( MG ); 

%% Objective function
f = [ ...
    MG.price.UG_in', MG.price.UG_out', zeros(1,MG.horizon*MG.numofUG), ...
    MG.price.CL_in', MG.price.CL_out', zeros(1,MG.horizon*MG.numofCL), ...
    MG.price.ES_in', MG.price.ES_out', zeros(1,MG.horizon*MG.numofES), ...
    zeros(1,MG.horizon*MG.numofEV),zeros(1,MG.horizon*MG.numofEV),zeros(1,MG.horizon*MG.numofEV), ...
    zeros(1,MG.horizon*MG.numofRE), ...
    zeros(1,MG.horizon*MG.numofL0), ...
    zeros(1,MG.horizon*MG.numofL1), ...
    zeros(1,MG.horizon*MG.numofL2), zeros(1, MG.numofL2*(MG.horizon+1)), zeros(1, MG.numofL2*(MG.horizon+1)) ];

%% Calculation: MILP
[MG.x,fval,exitflag,output] = intlinprog(f,MG.intcon,...
    MG.A.all,MG.b.all,...
    MG.Aeq.all,MG.beq.all, ...
    MG.lb.all,MG.ub.all);

%% Shape the results
MG = shapeResults( MG );
MG = cal_SOC(MG);
resultTable = array2table(MG.result, ...
    'VariableNames',MG.nameall);
