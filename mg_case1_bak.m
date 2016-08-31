function MG = mg_case1(numofMG)

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
L1 = 4;
L2 = 2;
%}

%%
MG.timespan = 5; % in minutes
MG.hours = 24; % in hours
MG.horizon = MG.hours * 60 / MG.timespan ;

%% UG: (1)
MG.numofUG = 1;
MG.UG = Model_UG( MG.casetype );

%% CL: (1)
MG.numofCL = 1;
MG.CL = Model_CL( MG.casetype );

%% ES: (1)
MG.numofES = 1;
MG.ES = Model_ES( MG.casetype ); %declare the type;

MG.ES.SOC_min = 0.1;
MG.ES.SOC_max = 0.9;
MG.ES.SOC_0 = 0.45;
MG.ES.SOC_T = 0.7;
MG.ES.price_in = 0.08;
MG.ES.price_out = -0.08;
%% EV: (1)
MG.numofEV = 1;
MG.EV = Model_EV( MG.casetype ); %declare the type;

MG.EV.SOC_min = 0.1;
MG.EV.SOC_max = 0.9;
MG.EV.avbl_h = [0 7.1 19 24];
MG.EV.flag = 1;
MG.EV.SOC = [0.5, 0.8, 0.2, 0.5];

%% RE: (1)
MG.numofRE = 1;
MG.RE.name = 'PV1';
MG = PV_home(MG);

%% L0: (1)
MG.numofL0 = 1;
MG.L0.name = 'base_load';
MG = L0_home(MG);

%% L1: (X)
MG.numofL1 = 4;
MG.L1 = struct('value',[],'name',[],'avbl_hours',[]); 
MG = add_load(MG,'washing_machine',1); 
MG = add_load(MG,'vacuum_cleaner',1); 
MG = add_load(MG,'air_conditioner',1); 
MG = add_load(MG,'oven',1); 

%% L2: (X)
MG.numofL2 = 2;
MG.L2 = struct('value',[],'name',[],'avbl_hours',[]);
MG = add_load(MG,'dish_washer',2);
MG = add_load(MG,'toaster',2); 

end

