clear;clc;

MG = MG_dataSetting();

%% Variables indices: UG, CL, ES, EV, RE, L0, L1, L2
%MG.UG_in, MG.UG_out, MG.UG_flg;
%MG.CL_in, MG.CL_out, MG.CL_flg;
%MG.ES_in, MG.ES_out, MG.ES_flg;
%MG.EV_in, MG.EV_out, MG.EV_flg;
%MG.RE_in, (flg)
%MG.L0_out; (flg)
%MG.L1_out; (flg)
%MG.L2_out; (flg)
%MG.L2_ind_s; MG.L2_ind_e;
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
MG = Ineq_UG_in( MG );
MG = Ineq_UG_out( MG );
MG = Ineq_CL_in( MG );
MG = Ineq_CL_out( MG );
MG = Ineq_ES_in( MG );
MG = Ineq_ES_out( MG );
MG = Ineq_ES_SOC( MG );
MG = Ineq_EV_in( MG );
MG = Ineq_EV_out( MG );
%% Inequality constraints: lb<=x<=ub
MG = Ineq_X( MG ); 

%% Objective function
f = [MG.price.UG_in(1:MG.horizon)', MG.price.UG_out(1:MG.horizon)', zeros(1,MG.horizon*MG.numofUG), ...
    MG.price.CL_in(1:MG.horizon)',MG.price.CL_out(1:MG.horizon)',zeros(1,MG.horizon*MG.numofCL), ...
    zeros(1,MG.horizon*MG.numofES),zeros(1,MG.horizon*MG.numofES),zeros(1,MG.horizon*MG.numofES), ...
    zeros(1,MG.horizon*MG.numofEV),zeros(1,MG.horizon*MG.numofEV),zeros(1,MG.horizon*MG.numofEV), ...
    zeros(1,MG.horizon*MG.numofRE), ...
    zeros(1,MG.horizon*MG.numofL0), ...
    zeros(1,MG.horizon*MG.numofL1), ...
    zeros(1,MG.horizon*MG.numofL2), zeros(1, MG.numofL2*(MG.horizon+1)), zeros(1, MG.numofL2*(MG.horizon+1)) ];

%% Calculation: MILP
[x,fval,exitflag,output] = intlinprog(f,MG.intcon,...
    MG.A.all,MG.b.all,...
    MG.Aeq.all,MG.beq.all, ...
    MG.lb,MG.ub);

%% Shape the results
MG = shapeResults( x, MG );

testp = array2table(MG.result, ...
    'VariableNames',MG.nameall);

