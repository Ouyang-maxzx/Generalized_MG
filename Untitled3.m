%function output = randomMG1 ( MG )
num = 10;

%% ES
MG.ES.SOC_range = repmat ([0.2, 0.2], num, 1) .* rand(10, 2) + repmat([0, 0.8], num, 1);
MG.ES.SOC_ST = repmat( [0.6, 0.3] , num, 1).* rand(10, 2) + repmat([0.2, 0.5], num, 1);
%for type 1


%EV

%RE:
nRE = normrnd(0,0.1,num,MG.horizon);
for i = 1:num
    MG.RE.value = max( MG.RE.value + nRE(i,:)', 0); 
    for j = 1:MG.horizon
        if (j>=0 && j<=6/MG.timespan*60)||(j>=18.5/MG.timespan*60 && j<=24/MG.timespan*60)
            MG.RE.value(j,1) = 0;
        end
    end
end
    

%end