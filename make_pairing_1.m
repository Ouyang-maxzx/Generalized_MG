function [output1, output2, output3] = make_pairing( input_M, MG_out, MG_sig)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

row = size(input_M, 1);

[~, pos_row] = min(input_M, [], 2);
%eliminate the un-participated MG:
for i = 1:1:row
   if MG_sig(row) == 0
       pos_row(row) = -1;
   end     
end

%select the pairing row:
pos_row_temp = pos_row;
pair_MG = [];
for i = 1:row
   if pos_row_temp(i) == -1
       %do nothing
   elseif pos_row_temp( pos_row_temp(i) ) == i
       pair_MG = [pair_MG;[i, pos_row_temp(i)]];
       temp = pos_row_temp(i);
       pos_row_temp(i) = -1;
       pos_row_temp( temp ) = -1; 
       clear temp;
   end
end
MG_pair_output = [];
%adjust the output/input sequence;
for i = 1:size(pair_MG, 1)
    if abs(MG_out(pair_MG(i,1))) >  abs(MG_out(pair_MG(i,2)))
        input_M = clear_out(input_M, pair_MG(i,2)); %clear the matrix;
        MG_sig(pair_MG(i,2)) = 0;
        
    elseif abs(MG_out(pair_MG(i,1))) <  abs(MG_out(pair_MG(i,2)))
        input_M = clear_out(input_M, pair_MG(i,1));
        MG_sig(pair_MG(i,1)) = 0;
    else
        input_M = clear_out(input_M, pair_MG(i,2));
        MG_sig(pair_MG(i,2)) = 0;
        input_M = clear_out(input_M, pair_MG(i,1));
        MG_sig(pair_MG(i,1)) = 0;
    end
end

output1 = input_M;
output2 = MG_sig;
output3 = MG_pair_output;
end

