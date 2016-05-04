[num,txt,raw] = xlsread( 'MG1.xlsx', 'INDEX');
for i = 2:size(raw, 1) %for each row
    switch txt{i,1} %check 
        case 'number'
            for j = 2:size(raw, 2) %for each line
                switch txt{1,j}
                  case 'UG'
                      MG.numofUG = raw{i,j};
                  case 'CL'
                      MG.numofCL = raw{i,j};
                  case 'ES'
                      MG.numofES = raw{i,j};
                  case 'EV'
                      MG.numofEV = raw{i,j};
                  case 'RE'
                      MG.numofRE = raw{i,j};
                  case 'L0'
                      MG.numofL0 = raw{i,j};
                  case 'L1'
                      MG.numofL1 = raw{i,j};
                  case 'L2'
                      MG.numofL2 = raw{i,j};
                  otherwise
                end
            end
        otherwise
    end
end