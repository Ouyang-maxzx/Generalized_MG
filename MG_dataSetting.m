function MG = MG_dataSetting( G , MG )
%% Variables indices:
%MG.UG_in, MG.UG_out, MG.UG_flg;
%MG.CL_in, MG.CL_out, MG.CL_flg;
%MG.ES_in, MG.ES_out, MG.ES_flg;
%MG.RE_in, (flg)
%MG.L0_out; (flg)
%MG.L1_out; (flg)
%MG.L2_out; (flg)
%MG.L2_ind_s; MG.L2_ind_e;

%% Import from global setting

%% Components
indexString = ['MG', num2str( MG.id ), '.xlsx'];
MG = importData (MG, G, indexString);
clear indexString;

%% Indicate the intcon:
MG.intcon = [ 
    MG.horizon*(2*MG.numofUG)+1:MG.horizon*(3*MG.numofUG), ... %UG
    MG.horizon*(3*MG.numofUG+2*MG.numofCL)+1:MG.horizon*(3*MG.numofUG+3*MG.numofCL), ... %CL
    MG.horizon*(3*MG.numofUG+3*MG.numofCL+2*MG.numofES)+1:MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES), ... %ES
    MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+2*MG.numofEV)+1:MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+3*MG.numofEV), ... %EV
    MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+3*MG.numofEV)+1: ...
    MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+3*MG.numofEV+MG.numofRE+MG.numofL0+MG.numofL1+MG.numofL2)+ ...%RE,L0,L1,L2, and
    MG.numofL2*(MG.horizon+1) + MG.numofL2*(MG.horizon+1) ... %L2_s, L2_e
    ];
%% Constraint Variables (ititialization of matricies)
MG.A.all = [];
MG.b.all = [];
MG.Aeq.all = [];
MG.beq.all = [];
MG.lb = [];
MG.ub = [];
%% 
% Aggregate the names
MG.nameall = [{'Time'}, MG.UG.name(1:MG.numofUG), MG.CL.name(1:MG.numofCL), MG.ES.name(1:MG.numofES), MG.EV.name(1:MG.numofEV), MG.RE.name(1:MG.numofRE), ...
    MG.L0.name(1:MG.numofL0), MG.L1.name(1:MG.numofL1), MG.L2.name(1:MG.numofL2) ];

%Reshape the contraints for ES: SOC to capacity
MG.ES.SOC_max = MG.ES.SOC_max.*MG.ES.cap./MG.timespan;
MG.ES.SOC_min = MG.ES.SOC_min.*MG.ES.cap./MG.timespan;
MG.ES.SOC_0 = MG.ES.SOC_0.*MG.ES.cap./MG.timespan;
MG.ES.SOC_T = MG.ES.SOC_T.*MG.ES.cap./MG.timespan;
end
