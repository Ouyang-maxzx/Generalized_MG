for i =1:24
    if sum(sum(abs(Final{i})))>0
        disp(i)
    end
end