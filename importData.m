function MG_out = importData (MG, G, docString)

%% Import the number and name of each component
[~,txt,raw] = xlsread( docString, 'INDEX');
% Import number:
naviRow = 2; % 'number'
for j = 2:size(raw, 2) %for each line
    switch txt{1,j}
        case 'UG'
            MG.numofUG = raw{naviRow,j};
            MG.UG.name = raw(4:4+MG.numofUG-1, j)';
        case 'CL'
            MG.numofCL = raw{naviRow,j};
            MG.CL.name = raw(4:4+MG.numofCL-1, j)';
        case 'ES'
            MG.numofES = raw{naviRow,j};
            %MG.ES.name = raw(4:4+MG.numofES-1, j)';
        case 'EV'
            MG.numofEV = raw{naviRow,j};
            MG.EV.name = raw(4:4+MG.numofEV-1, j)';
        case 'RE'
            MG.numofRE = raw{naviRow,j};
            %MG.RE.name = raw(4:4+MG.numofRE-1, j)';
        case 'L0'
            MG.numofL0 = raw{naviRow,j};
            MG.L0.name = raw(4:4+MG.numofL0-1, j)';
        case 'L1'
            MG.numofL1 = raw{naviRow,j};
            %MG.L1.name = raw(4:4+MG.numofL1-1, j)';
        case 'L2'
            MG.numofL2 = raw{naviRow,j};
            %MG.L2.name = raw(4:4+MG.numofL2-1, j)';
        case 'span'
            MG.timespan = raw{naviRow,j};
        otherwise
    end
end
clear naviRow txt raw;
%% 
MG.horizon =  G.horizon/MG.timespan;

%%  
%UG
[num,~,~] = xlsread( docString, 'Price');
MG.timeframe = num(1:MG.horizon,1).*24;
MG.price.UG_in = num(1:MG.horizon,2);
MG.price.UG_out = num(1:MG.horizon,3);
clear num;
rangeR = 1:MG.numofUG;
[num,txt,~] = xlsread( docString, 'UG');
for i = 2:size(num, 2)
  switch txt{i}          
      case 'UG_in'
          MG.UG.ub = num(rangeR,i)';
      case 'UG_out'
          MG.UG.lb = num(rangeR,i)';
      otherwise
  end
end
clear i rangeR num txt;

%CL
%price
[num,~,~] = xlsread( docString, 'Price');
MG.price.CL_in = num(1:MG.horizon,4);
MG.price.CL_out = num(1:MG.horizon,5);
clear num;
%input/output constraints
[num,txt,~] = xlsread( docString, 'CL');
for i = 2:size(num, 2)
  switch txt{i}
      case 'CL_in'
          MG.CL.ub = num(1:MG.horizon,i);
      case 'CL_out'
          MG.CL.lb = num(1:MG.horizon,i);
      otherwise
  end
end
clear i rangeR num txt;

%ES
rangeR = 1:MG.numofES;
[num,~,raw] = xlsread( docString, 'ES');
for i = 2:size(raw, 2)
  switch raw{1,i}
      case 'ES_name'
          MG.ES.name = raw(1+rangeR, i)';
      case 'ES_cost'
          MG.price.ES_in  =  num(rangeR,i)';
          MG.price.ES_out = -num(rangeR,i)';
      case 'ES_in'
          MG.ES.ub = num(rangeR,i)';
      case 'ES_out'
          MG.ES.lb = num(rangeR,i)';
      case 'ES_cap'
          MG.ES.cap = num(rangeR,i)';
      case 'SOC_min'
          MG.ES.SOC_min = num(rangeR,i)';
      case 'SOC_max'
          MG.ES.SOC_max = num(rangeR,i)';
      case 'SOC_0'
          MG.ES.SOC_0 = num(rangeR,i)';
      case 'SOC_T'
          MG.ES.SOC_T = num(rangeR,i)';
      otherwise
  end
end
clear i rangeR num raw;

%EV 
rangeR = 1:MG.numofEV;
[num,~,raw] = xlsread( docString, 'EV');
for i = 2:size(raw, 2)
  switch raw{1,i}
      case 'EV_name'
          MG.EV.name = raw(1+rangeR, i)';
      case 'EV_cost'
          MG.price.EV_in  =  num(rangeR,i)';
          MG.price.EV_out = -num(rangeR,i)';
      case 'EV_in'
          MG.EV.ub = num(rangeR,i)';
      case 'EV_out'
          MG.EV.lb = num(rangeR,i)';
      case 'EV_cap'
          MG.EV.cap = num(rangeR,i)';
      case 'SOC_min'
          MG.EV.SOC_min = num(rangeR,i)';
      case 'SOC_max'
          MG.EV.SOC_max = num(rangeR,i)';
      case 'SOC_0'
          MG.EV.SOC_0 = num(rangeR,i)';
      case 'SOC_T'
          MG.EV.SOC_T = num(rangeR,i)';
      otherwise
  end
end
clear i rangeR num raw;

%RE
rangeR = 1:MG.horizon;
[num,~, raw] = xlsread( docString, 'RE');
MG.RE.value = num(rangeR,2:1+MG.numofRE);
MG.RE.name = raw(1 , 2:1+MG.numofRE);
clear num raw;

%L0
rangeR = 1:MG.horizon;
[num,~,raw] = xlsread( docString, 'L0');
MG.L0.value = num(rangeR,2:size(num,2));
MG.L0.nameall = raw(1,2:size(num,2));
MG.L0.value = -sum(MG.L0.value ,2);
MG.L0.name = {'Base_Load'};
clear rangeR num txt;
%L1
rangeR = 1:MG.horizon;
rangeC = 1:MG.numofL1;
[num,~,raw] = xlsread( docString, 'L1');
MG.L1.value = -num(rangeR, 1+rangeC);
MG.L1.name = raw(1, 1+rangeC);
for i = 2:size(raw, 2)
    switch raw{1,i}
        case 'A_hour'
            MG.L1.avbl_hours = num(rangeC,i)'./MG.timespan;
        otherwise
    end
end
clear rangeR rangeC num raw;
%L2
rangeR = 1:MG.horizon;
rangeC = 1:MG.numofL2;
[num,~,raw] = xlsread( docString, 'L2');
MG.L2.value = -num(rangeR, 1+rangeC);
MG.L2.name = raw(1, 1+rangeC);
for i = 2:size(raw, 2)
    switch raw{1,i}
        case 'A_hour'
            MG.L2.avbl_hours = num(rangeC,i)'./MG.timespan;
        otherwise
    end
end
clear rangeR rangeC num raw;

MG_out = MG;
end
