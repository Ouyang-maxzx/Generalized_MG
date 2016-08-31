function output = EV_list (numofMG)
num = numofMG;

ES_l_s = 0.1;
ES_l_var = 0.1; %0.1-0.2
ES_u_s = 0.8;
ES_u_var = 0.1; %0.8-0.9

ES_big_s = 0.4;
ES_big_var = 0.2; %0.4-0.6 
ES_end_s = 0.3;
ES_end_var = 0.5; %0.3-0.8

%% ES
Gdata.ES.SOC_range = repmat ([ES_l_var, ES_u_var], num, 1) .* rand(num, 2) + repmat([ES_l_s, ES_u_s], num, 1);
Gdata.ES.SOC_ST = repmat( [ES_big_s, ES_end_s] , num, 1).* rand(num, 2) + repmat([ES_big_var, ES_end_var], num, 1);
%% EV
%Gdata.EV.SOC_range = repmat ([0.2, 0.2], num, 1) .* rand(num, 2) + repmat([0, 0.8], num, 1);
%Gdata.EV.avbl_hours = repmat( [0 4 4 0], num, 1).*rand(num,4) + repmat([0, 6, 17, 24], num, 1);



output = Gdata;
end