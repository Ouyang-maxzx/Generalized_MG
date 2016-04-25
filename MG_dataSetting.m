function MG = MG_dataSetting()

% Components: 
MG.numofUG = 1;	% Utility grid
MG.numofCL = 1; % Clutster of neighbourhood
MG.numofES = 1; % Energy storage
MG.numofEV = 0; % Electric Vehicle
MG.numofRE = 1; % Renewables
MG.numofL0 = 1; % Load type 0 (fixed load)
MG.numofL1 = 3; % Load type 1 (controllable and interruptible load) 
MG.numofL2 = 2; % Load type 2 (controllable and uninterruptible load)

%fprintf('UG: %d\nCluster: %d\nES: %d\n',MG.numofUG,MG.numofUG,MG.numofUG);


MG.A.all = [];
MG.b.all = [];
MG.Aeq.all = [];
MG.beq.all = [];
MG.lb = [];
MG.ub = [];



%% Variables indices:
%MG.UG_in, MG.UG_out, MG.UG_flg;
%MG.CL_in, MG.CL_out, MG.CL_flg;
%MG.ES_in, MG.ES_out, MG.ES_flg;
%MG.RE_in, (flg)
%MG.L0_out; (flg)
%MG.L1_out; (flg)
%MG.L2_out; (flg)
%MG.L2_ind_s; MG.L2_ind_e;

%%
MG.horizon = 24;
%%Data
MG.price = [0.2887
0.2172
0.1729
0.1748
0.1888
0.2074
0.2781
0.3125
0.3642
0.3768
0.4904
0.4197
0.4517
0.4431
0.5605
0.4422
0.3459
0.3066
0.2849
0.3099
0.2983
0.2174
0.2279
0.2088];
MG.L0.value = -[2.835
2.835
2.835
2.835
3.435
2.135
1.845
1.685
1.685
1.685
1.985
2.885
1.685
1.685
1.685
1.685
2.335
3.235
3.435
3.135
3.435
3.535
2.865
2.835];
MG.L1.value  = -[2	0.7	0.6
0	0	0
0	0	0
0	0	0
0	0	0
0	0	0
0	0	0
2	0.7	0
2	0.7	0
2	0.7	0.6
0	0.7	0.6
0	0.7	0.6
0	0.7	0.6
2	0.7	0.6
2	0.7	0.6
2	0.7	0.6
0	0.7	0.6
0	0.7	0.6
0	0.7	0.6
2	0.7	0.6
2	0.7	0.6
2	0.7	0
0	0	0
0	0	0
];
MG.RE.value = [0
0
0
0
0
0
0
0
0.27
1.67
2.62
3.57
3.95
3.87
3.23
2.73
1.18
0
0
0
0
0
0
0
];
MG.L2.value = -0.01*[5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5;5,5,5];
MG.UG.name = {'Utility'};
MG.CL.name = {'Cluster1'};
MG.ES.name = {'ES1'};
MG.EV.name = {'EV1'};
MG.RE.name = {'PV'};
MG.L0.name = {'Base_Load'};
MG.L1.name = {'Dishwasher','Washing_Machine', 'Vacuum_Cleaner' };
MG.L1.avbl_hours = [1,1,1];
MG.L2.name = {'L2_Device1', 'L2_Device2'};
MG.L2.avbl_hours = [2 10 3];
MG.nameall = [MG.UG.name(1:MG.numofUG), MG.CL.name(1:MG.numofCL), MG.ES.name(1:MG.numofES), MG.EV.name(1:MG.numofEV), MG.RE.name(1:MG.numofRE), ...
    MG.L0.name(1:MG.numofL0), MG.L1.name(1:MG.numofL1), MG.L2.name(1:MG.numofL2) ];
%MG.EV.name,
MG.UG.lb = [-8];
MG.UG.ub = [8];
MG.CL.lb = [0];
MG.CL.ub = [0];
MG.ES.lb = [-4];
MG.ES.ub = [4];
MG.EV.lb = [-4];
MG.EV.ub = [4];

%Reshape
MG.UG.lb = repmat(MG.UG.lb, MG.horizon, 1);
MG.UG.ub = repmat(MG.UG.ub, MG.horizon, 1);
MG.CL.lb = repmat(MG.CL.lb, MG.horizon, 1);
MG.CL.ub = repmat(MG.CL.ub, MG.horizon, 1);
MG.ES.lb = repmat(MG.ES.lb, MG.horizon, 1);
MG.ES.ub = repmat(MG.ES.ub, MG.horizon, 1);
MG.EV.lb = repmat(MG.EV.lb, MG.horizon, 1);
MG.EV.ub = repmat(MG.EV.ub, MG.horizon, 1);

MG.SOC_intl = [45]/4;
MG.SOC_max = [90]/4;
MG.SOC_min = [10]/4;

end
