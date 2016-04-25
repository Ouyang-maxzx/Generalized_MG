clear;clc;

MG = MG_dataSetting();

%Components: Load, ES, RE, UG, CL

%Testing data


%{
%MG.RE = zeros( MG.horizon, MG.numofRE); %Set as parameters
%MG.L0 = zeros( MG.horizon, MG.numofL0); %Set as parameters
%MG.L1 = zeros( MG.horizon, MG.numofL1); %Set as parameters
%MG.L2 = zeros( MG.horizon, MG.numofL2); %Set as parameters
%Testing data end

%MG.UG = zeros(MG.horizon, MG.numofUG); %Set as variables
%MG.CL = zeros(MG.horizon, MG.numofCL); %Set as variables
%MG.ES = zeros(MG.horizon, MG.numofES); %Set as variables
%Additional Constraitnts for interruputible loads:
%MG.RE_ind = ones(MG.horizon, MG.numofRE); %This indicator should be always 1. 
%MG.L0_ind = zeros(MG.horizon, MG.numofL0); %This indicator should be always 1. 
%MG.L1_ind = zeros(MG.horizon, MG.numofL1); %Set as variables
%MG.L2_ind = zeros(MG.horizon, MG.numofL2); %Set as variables
%}
%% re-arrange the variables:
%{
%UG: 
MG.UG_re = reshape(MG.UG,[],1);
%CL
MG.CL_re = reshape(MG.CL,[],1);
%ES
MG.ES_re = reshape(MG.ES,[], 1);
%RE
MG.RE_ind_re = reshape(MG.RE_ind,[],1);
%Load0
MG.L0_ind_re = reshape(MG.L0_ind,[],1);
%Load1
MG.L1_ind_re = reshape(MG.L1_ind,[],1);
%Load2
MG.L2_ind_re = reshape(MG.L2_ind,[],1);
%total:

%}
%Sequence: 
%MG.x = [ MG.UG_re;MG.CL_re;MG.ES_re;MG.RE_ind_re;MG.L0_ind_re;MG.L1_ind_re;MG.L2_ind_re; MG.L2_s; MG.L2_e ];
%Indicate the intcon:
intcon = [ 
    MG.horizon*(2*MG.numofUG)+1:MG.horizon*(3*MG.numofUG), ... %UG
    MG.horizon*(3*MG.numofUG+2*MG.numofCL)+1:MG.horizon*(3*MG.numofUG+3*MG.numofCL), ... %CL
    MG.horizon*(3*MG.numofUG+3*MG.numofCL+2*MG.numofES)+1:MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES), ... %ES
    MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+2*MG.numofEV)+1:MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+3*MG.numofEV), ... %EV
    MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+3*MG.numofEV)+1: ...
    MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+3*MG.numofEV+MG.numofRE+MG.numofL0+MG.numofL1+MG.numofL2)+ ...%RE,L0,L1,L2, and
    MG.numofL2*(MG.horizon+1) + MG.numofL2*(MG.horizon+1) ... %L2_s, L2_e
    ];

%% Constraints: 
% --What are included in x?
% --UG, CL, ES, RS_ind, Load_ind.

%% Equality constraints:
%Power balance
MG = Eq_Constraints_Power( MG );
%Indicator for L0: should be always 1

%Indicator for L1: should meet the operation time intervals
MG = Eq_Consraints_L1_flg( MG );
%Indicator for L2: should meet the operation time intervals
MG = Eq_Consraints_L2_flg( MG );
%Indicator for L2: Additional 
MG = Eq_Constraints_L2_continuous( MG );
MG = Eq_Constraints_L2_s( MG );
MG = Eq_Constraints_L2_e( MG );
%% Inequality constraints: A*x<=b

%% Inequality constraints: lb<=x<=ub
MG = Ineq_UG_in( MG );
MG = Ineq_UG_out( MG );
MG = Ineq_CL_in( MG );
MG = Ineq_CL_out( MG );
MG = Ineq_ES_in( MG );
MG = Ineq_ES_out( MG );
MG = Ineq_ES_SOC( MG );
MG = Ineq_EV_in( MG );
MG = Ineq_EV_out( MG );


MG = Ineq_Constraints_X( MG ); 

%%
f = [MG.price(1:MG.horizon)', MG.price(1:MG.horizon)', zeros(1,MG.horizon*MG.numofUG), ...
    zeros(1,MG.horizon*MG.numofCL),zeros(1,MG.horizon*MG.numofCL),zeros(1,MG.horizon*MG.numofCL), ...
    zeros(1,MG.horizon*MG.numofES),zeros(1,MG.horizon*MG.numofES),zeros(1,MG.horizon*MG.numofES), ...
    zeros(1,MG.horizon*MG.numofEV),zeros(1,MG.horizon*MG.numofEV),zeros(1,MG.horizon*MG.numofEV), ...
    zeros(1,MG.horizon*MG.numofRE), ...
    zeros(1,MG.horizon*MG.numofL0), ...
    zeros(1,MG.horizon*MG.numofL1), ...
    zeros(1,MG.horizon*MG.numofL2), zeros(1, MG.numofL2*(MG.horizon+1)), zeros(1, MG.numofL2*(MG.horizon+1)) ];


%% Calculation: MILP
[x,fval,exitflag,output] = intlinprog(f,intcon,...
    MG.A.all,MG.b.all,...
    MG.Aeq.all,MG.beq.all, ...
    MG.lb,MG.ub);

%% Shape the results
MG = shapeResults( x, MG );

testp = array2table(MG.result, ...
    'VariableNames',MG.nameall);

