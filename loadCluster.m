function load_out = loadCluster(string)

switch string
    case 'dish_washer'
        load_out.name = 'dish_washer';
        load_out.avbl_h = [0,4,9,11,14.5,17,20,24];
        load_out.oper_h = 1;
        load_out.flag = 1;
        load_out.power = -1;
        load_out.type = 1;
    case 'washing_machine'
        load_out.name = 'washing_machine';
        load_out.avbl_h = [0,1,2,4,6,24];
        load_out.oper_h = 2;
        load_out.flag = 1;
        load_out.power = -0.7;
        load_out.type = 1;
    case 'vacuum_cleaner'
        load_out.name = 'vacuum_cleaner';
        load_out.avbl_h = [0,1,2,4,6,24];
        load_out.oper_h = 4;
        load_out.flag = 1;
        load_out.power = -0.6;
        load_out.type = 1;              
    otherwise
        error('No such load!')
end


end