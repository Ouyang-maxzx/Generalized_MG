function  MG_out = PV_home (MG)

PV = [
0
0
0
0
0
0
0
0
0.27
1.67
2.62
3.57
3.95
3.87
3.23
2.73
1.18
0
0
0
0
0
0
0 ];
value = [];
if length(PV) == 24
    PV = [PV; 0]; % Add a zero at last to form the last hour
    for i = 1:1:size(PV)-1
        value = [value,linspace(PV(i,1), PV(i+1,1), 60/MG.timespan+1)];
        value = value(1:size(value,2)-1);
    end
else
    error('Wrong in forming RE values');
end

MG.RE.value = value';

MG_out = MG;
end