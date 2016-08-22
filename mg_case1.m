function MG = mg_case1

%% Type
MG.casetype = 1;
MG.case = 'home_1';

%% number of components:
%{
UG = 1;
CL = 1;
ES = 1;
EV = 1; %%
RE = 1;
L0 = 1;
L1 = 3;
L2 = 2;
%}

%%
MG.timespan = 5; % in minutes
MG.hours = 24; % in hours
MG.horizon = MG.hours * 60 / MG.timespan ;

%% UG: (1)
MG.numofUG = 1;
MG.UG.name = 'Utility';
MG.UG.ub = 8;
MG.UG.lb = -8;

%% CL: (1)
MG.numofCL = 1;
MG.CL.name = 'Community';
MG.CL.ub = 0;
MG.CL.lb = -0;

%% ES: (1)
MG.numofES = 1;
MG.ES.name = {'ES1'};
MG.ES.ub = 4;
MG.ES.lb = -4;
MG.ES.cap = 8;
MG.ES.SOC_min = 0.1;
MG.ES.SOC_max = 0.9;
MG.ES.SOC_0 = 0.45;
MG.ES.SOC_T = 0.7;
MG.price.ES_in = 0.08;
MG.price.ES_out = -0.08;
%% EV: (1)
MG.numofEV = 1;
MG.EV.name = {'ES1'};
MG.EV.ub = 4;
MG.EV.lb = -4;
MG.EV.cap = 8;
MG.EV.SOC_min = 0.1;
MG.EV.SOC_max = 0.9;
MG.EV.SOC_0 = 0.45;
MG.EV.SOC_T = 0.7;
MG.EV.TIME_d = 7;
MG.EV.TIME_a = 19;
MG.price.EV_in = 0.08;
MG.price.EV_out = -0.08;
%% RE: (1)
MG.numofRE = 1;
MG.RE.name = 'PV1';
MG = PV_home(MG);

%% L0: (1)
MG.numofL0 = 1;
MG.L0.name = 'base_load';
%MG.L0.value = [-2.83500000000000;-2.83500000000000;-2.83500000000000;-2.83500000000000;-3.43500000000000;-3.13500000000000;-2.83500000000000;-2.83500000000000;-2.83500000000000;-2.83500000000000;-1.83500000000000;-2.13500000000000;-2.13500000000000;-1.84500000000000;-1.69500000000000;-1.68500000000000;-1.68500000000000;-2.88500000000000;-1.68500000000000;-1.68500000000000;-1.68500000000000;-1.98500000000000;-1.98500000000000;-2.88500000000000;-2.88500000000000;-1.68500000000000;-1.68500000000000;-1.68500000000000;-1.68500000000000;-1.68500000000000;-1.68500000000000;-1.83500000000000;-1.83500000000000;-2.33500000000000;-2.33500000000000;-4.33500000000000;-4.33500000000000;-3.43500000000000;-3.43500000000000;-3.13500000000000;-3.13500000000000;-3.43500000000000;-3.23500000000000;-3.46500000000000;-3.46500000000000;-2.83500000000000;-2.83500000000000;-2.83500000000000];
MG = L0_home(MG);
%% L1: (X)
MG.numofL1 = 3;
MG.L1 = struct('value',[],'name',[],'avbl_hours',[]);
MG = add_load(MG,'dish_washer',1);  
MG = add_load(MG,'washing_machine',1); 
MG = add_load(MG,'vacuum_cleaner',1); 

%% L2: (X)
MG.numofL2 = 1;
MG.L2 = struct('value',[],'name',[],'avbl_hours',[]);
MG = add_load(MG,'dish_washer',2);



end

