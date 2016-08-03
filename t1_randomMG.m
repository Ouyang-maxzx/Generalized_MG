function output1 = t1_randomMG(inputString, numofMG)
load(inputString, 'MG');
MG_Group = cell(numofMG,1);

    for i = 1:numofMG
        MG_Group{i,1} = MG;
    end

    %L0 distribution
    nL0 = normrnd(0,0.5,MG.horizon,numofMG);
    for i = 1:numofMG
        MG_Group{i,1}.L0.value = MG_Group{i,1}.L0.value + nL0(:,i);    
    end

    %L1;
    nL1 = normrnd(0,0.15,MG.numofL1,numofMG);
    %change the load power
    for i = 1:numofMG
        MG_Group{i,1}.L1.value = MG_Group{i,1}.L1.value.*repmat((1+nL1(:,i))', MG.horizon, 1);    
    end

    %L2;
    nL2 = normrnd(0,0.15,MG.numofL2,numofMG);
    %change the load power
    for i = 1:numofMG
        MG_Group{i,1}.L2.value = MG_Group{i,1}.L2.value.*repmat((1+nL2(:,i))', MG.horizon, 1);    
    end

    %RE;
    nRE = normrnd(0,0.15,MG.horizon,numofMG);
    for i = 1:numofMG
        MG_Group{i,1}.RE.value = 0.35* max( MG_Group{i,1}.RE.value + nRE(:,i), 0); 
        for j = 1:MG.horizon
            if (j>=0 && j<=6/MG.timespan)||(j>=18.5/MG.timespan && j<=24/MG.timespan)
                MG_Group{i,1}.RE.value(j,1) = 0;
            end
        end
    end
    
    
    %ES
    nES = normrnd(0,0.01, MG.numofES, numofMG);
    for i = 1: numofMG
        MG_Group{i,1}.ES.SOC_0 =  min ( MG_Group{i,1}.ES.SOC_max, max( ...
            MG_Group{i,1}.ES.SOC_0 + nES(:,i)'.*MG_Group{i,1}.ES.cap, MG_Group{i,1}.ES.SOC_min ) );  
    end

output1 = MG_Group;
end





