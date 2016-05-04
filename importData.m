function MG_out = importData (MG, docString)
rangeT = MG.horizon;
%UG
MG.UG.name = {'Utility'};
[num,~,~] = xlsread( docString, 'Price');
MG.price.UG_in = num(1:rangeT,2);
MG.price.UG_out = num(1:rangeT,3);
clear num;
rangeV = 1:MG.numofUG;
[num,txt,~] = xlsread( docString, 'UG');
for i = 2:size(num, 2)
  switch txt{i}
      case 'UG_in'
          MG.UG.ub = num(rangeV,i)';
      case 'UG_out'
          MG.UG.lb = num(rangeV,i)';
      otherwise
  end
end
clear rangeV num txt;

%CL
MG.CL.name = {'Cluster1','Cluster2'};
[num,~,~] = xlsread( docString, 'Price');
MG.price.CL_in = num(1:rangeT,4);
MG.price.CL_out = num(1:rangeT,5);
clear num;

[num,txt,~] = xlsread( docString, 'CL');
for i = 2:size(num, 2)
  switch txt{i}
      case 'CL_in'
          MG.CL.ub = num(1:rangeT,i);
      case 'CL_out'
          MG.CL.lb = num(1:rangeT,i);
      otherwise
  end
end
clear rangeV num txt;

%ES
rangeV = 1:MG.numofES;
[num,~,raw] = xlsread( docString, 'ES');
for i = 2:size(raw, 2)
  switch raw{1,i}
      case 'ES_name'
          MG.ES.name = raw(1+rangeV, i)';
      case 'ES_cost'
          MG.price.ES_in  =  num(rangeV,i)';
          MG.price.ES_out = -num(rangeV,i)';
      case 'ES_in'
          MG.ES.ub = num(rangeV,i)';
      case 'ES_out'
          MG.ES.lb = num(rangeV,i)';
      case 'ES_cap'
          MG.ES.cap = num(rangeV,i)';
      case 'SOC_min'
          MG.ES.SOC_min = num(rangeV,i)';
      case 'SOC_max'
          MG.ES.SOC_max = num(rangeV,i)';
      case 'SOC_0'
          MG.ES.SOC_0 = num(rangeV,i)';
      case 'SOC_T'
          MG.ES.SOC_T = num(rangeV,i)';
      otherwise
  end
end
clear rangeV num txt;


%RE
rangeV = 1:MG.horizon;
[num,raw] = xlsread( docString, 'RE');
MG.RE.value = num(rangeV,2:1+MG.numofRE);
MG.RE.name = raw(1 , 2:1+MG.numofRE);
clear num txt;

%L0
rangeV = 1:MG.horizon;
[num,~,raw] = xlsread( docString, 'L0');
MG.L0.value = num(rangeV,2:size(num,2));
MG.L0.nameall = raw(1,2:size(num,2));
MG.L0.value = -sum(MG.L0.value ,2);
MG.L0.name = {'Base_Load'};
clear rangeV num txt;
%L1
rangeV = 1:MG.horizon;
rangeH = 1:MG.numofL1;
[num,~,raw] = xlsread( docString, 'L1');
MG.L1.value = -num(rangeV, 1+rangeH);
MG.L1.name = raw(1, 1+rangeH);
for i = 2:size(raw, 2)
    switch raw{1,i}
        case 'A_hour'
            MG.L1.avbl_hours = num(rangeH,i)';
        otherwise
    end
end
clear rangeV rangeH num ~ raw;
%L2
rangeV = 1:MG.horizon;
rangeH = 1:MG.numofL2;
[num,~,raw] = xlsread( docString, 'L2');
MG.L2.value = -num(rangeV, 1+rangeH);
MG.L2.name = raw(1, 1+rangeH);
for i = 2:size(raw, 2)
    switch raw{1,i}
        case 'A_hour'
            MG.L2.avbl_hours = num(rangeH,i)';
        otherwise
    end
end
clear rangeV rangeH num ~ raw;

MG_out = MG;
end
