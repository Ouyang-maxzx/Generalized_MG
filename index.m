clear;clc;

G = globalSetting();
MG_Group = cell(G.numofMG, 1);

%%
for M_index = 1:G.numofMG;
    %% Initialize data:
    MG.id = M_index;
    MG = MG_dataSetting(G, MG);
    
    %% Add All constraints:
    MG = AddAllConstraints( MG );
    
    %% Objective function
    MG = AddObjFunction( MG );
    
    %% Calculation: MILP
    MG.processTime = tic;
    [MG.x,fval,exitflag,output] = intlinprog(MG.f, MG.intcon,...
        MG.A.all, MG.b.all,...
        MG.Aeq.all, MG.beq.all, ...
        MG.lb.all, MG.ub.all);
    MG.processTime = toc( MG.processTime );
    
    %% Shape the results
    MG = shapeResults( MG );
    MG = cal_SOC(MG);
    MG.resultTable = array2table([MG.timeframe(1 : MG.horizon), MG.result ], ...
        'VariableNames',MG.nameall);
    MG_Group{M_index, 1} =formalize2G( MG, G );
    
    clear MG;
end



