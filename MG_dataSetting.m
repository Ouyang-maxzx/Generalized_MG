function MG_Group = MG_dataSetting( G  )
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

%% Components New

%MG_Group = t1_randomMG('mg1.mat', G.t1_MG);
%MG_Group = [ MG_Group; t2_randomMG('mg2_agg.mat', G.t2_MG) ];
%MG_Group = [ MG_Group; t3_randomMG('mg3.mat', G.t3_MG) ];

MG_Group = cell(30,1);
for p = 1:30
    MG_Group{p,1} = mg_case1;
end

for i = 1:1:G.numofMG
MG = MG_Group{i,1};
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
    MG.ES.SOC_max = MG.ES.SOC_max.*MG.ES.cap./MG.timespan.*60;
    MG.ES.SOC_min = MG.ES.SOC_min.*MG.ES.cap./MG.timespan.*60;
    MG.ES.SOC_0 = MG.ES.SOC_0.*MG.ES.cap./MG.timespan.*60;
    MG.ES.SOC_T = MG.ES.SOC_T.*MG.ES.cap./MG.timespan.*60;

    MG.EV.SOC_max = MG.EV.SOC_max.*MG.EV.cap./MG.timespan.*60;
    MG.EV.SOC_min = MG.EV.SOC_min.*MG.EV.cap./MG.timespan.*60;
    MG.EV.SOC_0 = MG.EV.SOC_0.*MG.EV.cap./MG.timespan.*60;
    MG.EV.SOC_T = MG.EV.SOC_T.*MG.EV.cap./MG.timespan.*60;

    
MG_Group{i,1} = MG;
end

end
