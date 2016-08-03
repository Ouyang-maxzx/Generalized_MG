clear;clc;

G = globalSetting();

%%
MG_Group = MG_dataSetting(G);
parTime = tic();
parfor M_index = 1:G.numofMG;
    MG = MG_Group{M_index, 1};
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
    

end
clear MG;
parTime = toc(parTime);

W = cell(G.horizon,1);
W_0 = genLocation(G.numofMG);
for i = 1:G.horizon
    W{i,1} = W_0;
end

MG_out = zeros(G.horizon, G.numofMG);
for i = 1:G.numofMG
    MG_out(:,i) = MG_Group{i,1}.result2G(:,1);
end
%Make pairings
T = 24;
Final = cell(T,1);
for t = 1:1:T
   [~,~,~,Final{t,1}] = wtf_1(W{t,1},MG_out(t,:) );
end


