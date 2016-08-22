function  MG_out = L0_home (MG)

L0 = [-2.83500000000000;-2.83500000000000;-2.83500000000000;-2.83500000000000;-3.43500000000000;-3.13500000000000;-2.83500000000000;-2.83500000000000;-2.83500000000000;-2.83500000000000;-1.83500000000000;-2.13500000000000;-2.13500000000000;-1.84500000000000;-1.69500000000000;-1.68500000000000;-1.68500000000000;-2.88500000000000;-1.68500000000000;-1.68500000000000;-1.68500000000000;-1.98500000000000;-1.98500000000000;-2.88500000000000;-2.88500000000000;-1.68500000000000;-1.68500000000000;-1.68500000000000;-1.68500000000000;-1.68500000000000;-1.68500000000000;-1.83500000000000;-1.83500000000000;-2.33500000000000;-2.33500000000000;-4.33500000000000;-4.33500000000000;-3.43500000000000;-3.43500000000000;-3.13500000000000;-3.13500000000000;-3.43500000000000;-3.23500000000000;-3.46500000000000;-3.46500000000000;-2.83500000000000;-2.83500000000000;-2.83500000000000];

value = [];
if length(L0) == 48
    L0 = [L0; 0]; % Add a zero at last to form the last hour
    for i = 1:1:size(L0)-1
        value = [value,linspace(L0(i,1), L0(i+1,1), 30/MG.timespan+1)];
        value = value(1:size(value,2)-1);
    end
else
    error('Wrong in forming RE values');
end

MG.L0.value = value';

MG_out = MG;
end