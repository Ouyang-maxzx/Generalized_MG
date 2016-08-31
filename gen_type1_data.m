function output = gen_type1_data (numofMG)

timespan = 5;
hours = 24;
horizon = hours *60 /timespan;

num = numofMG;

%% ES
% lower/upper %0.1-0.2 %0.8-0.9
ES_lu_s = [ 0.1, 0.8 ];
ES_lu_var = [ 0.1, 0.1 ];
% begin/end %0.4-0.6 %0.3-0.8
ES_be_s = [ 0.4, 0.3 ];
ES_be_var = [ 0.2, 0.5];
%
Gdata.ES.SOC_range = repmat (ES_lu_var, num, 1) .* rand(num, 2) + repmat(ES_lu_s, num, 1);
Gdata.ES.SOC_ST = repmat( ES_be_var , num, 1).* rand(num, 2) + repmat(ES_be_s, num, 1);
%% EV 
% lower/upper %0.1-0.2 %0.8-0.9
EV_lu_s = [ 0.1, 0.8];
EV_lu_var = [ 0.1, 0.1 ];
%
EV_avbl_h_s = [ 6, 17 ];
EV_avbl_h_var = [4 4]; 
% departure/arrival
EV_da_s = [0.4 0.6 0.2 0.4];
EV_da_var = [0.2 0.2 0.2 0.2];
%
Gdata.EV.SOC_range = repmat (EV_lu_var, num, 1) .* rand(num, 2) + repmat( EV_lu_s, num, 1);
Gdata.EV.avbl_h = repmat( [0, EV_avbl_h_var, 0], num, 1).*rand(num,4) + repmat([0, EV_avbl_h_s, 24], num, 1);
Gdata.EV.SOC = repmat (EV_da_var, num, 1) .* rand(num, 4) + repmat( EV_da_s, num, 1);


%% PV
PV_var = 0.15;
load('PV_type1'); % introduce 'PV_type1'
value = [];
if length(PV_type1) == 24
    PV_type1 = [PV_type1; 0]; % Add a zero at last to form the last hour
    for i = 1:1:size(PV_type1)-1
        value = [value,linspace(PV_type1(i,1), PV_type1(i+1,1), 60/timespan+1)];
        value = value(1:size(value,2)-1);
    end
else
    error('Wrong in forming RE values');
end
value = repmat(value, num , 1);
% randomize PV
nRE = normrnd(0, PV_var ,num, horizon);
for i = 1:1:num
    value(i,:) = max( value(i,:) + nRE(i,:), 0); 
    for j = 1 : horizon
        if (j>=0 && j<=6/timespan*60)||(j>=18.5/timespan*60 && j<=24/timespan*60)
            value(i,j) = 0;
        end
    end
end
Gdata.PV = value; 
clear value;

%% L0
L0_var = 0.1;
load('L0_type1'); % introduce 'PV_type1'
value = [];
if length(L0_type1) == 48
    L0_type1 = [L0_type1; 0]; % Add a zero at last to form the last hour
    for i = 1:1:size(L0_type1)-1
        value = [value,linspace(L0_type1(i,1), L0_type1(i+1,1), 30/timespan+1)];
        value = value(1:size(value,2)-1);
    end
else
    error('Wrong in forming L0 values');
end
value = repmat(value, num , 1);
% randomize L0
nL0 = normrnd(0, L0_var ,num, horizon);
value = min( value + nL0, 0);
Gdata.L0 = value; 
clear value;

output = Gdata;
end