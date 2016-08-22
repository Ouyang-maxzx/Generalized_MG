for t = 1:1:T
    MG_out_add(t,:) =  sum( Final{t,1}, 1);
end

MG_p = MG_out + MG_out_add;

%Total exchanged energy
MG_out_p = sum( (MG_out_add>0).*MG_out_add, 2 );