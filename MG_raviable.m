MG_via = mg_case1;

%% ES
nES = normrnd(0,0.01, MG_via.numofES, 1);
MG.ES.SOC_0 = G.ES.SOC_0 + nES ;

%% RE
nRE = normrnd(0,0.15,MG_via.horizon,1);
MG_via.RE.value = 0.35* max( MG_via.RE.value + nRE, 0); 
for j = 1:MG_via.horizon
    if (j>=0 && j<=6/MG_via.timespan*60)||(j>=18.5/MG_via.timespan*60 && j<=24/MG_via.timespan*60)
        MG_via.RE.value(j,1) = 0;
    end
end

%%L1


