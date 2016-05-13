G.meshedUG = zeros(G.horizon, G.numofMG);
G.meshedCL = zeros(G.horizon, G.numofMG);
for j = 1:G.numofMG
   G.meshedUG(:,j)  = MG_Group{j,1}.result2G(:,1);
end
allIn = G.meshedUG>0;
allOut = G.meshedUG<0;
allInSum = sum(allIn, 2);
allOutSum = sum(allOut, 2);
allInUG = allIn.*G.meshedUG;
allOutUG = allOut.*G.meshedUG;
totalUG = sum(G.meshedUG, 2);

for i = 1:G.horizon
	if totalUG(i)>0
        if sum( allIn(i,:), 2 ) < G.numofMG
            standard = sum(allOutUG(i,:))/allInSum(i,:) ; %Setting the changing reference
        else %all >0
            %Do nothing
        end
	elseif totalUG<0
      standard = sum(allInUG(i,:))/allOutSum(i,:)  ;
	else
	end
       
end



for i = 1:G.horizon
   switch allInSum(i,1)
       case G.numofMG
           %Do nothing 
       otherwise
           if G.totalUG(i>0)
              for j = 1:G.numofMG
                 if G.meshedUG(i,j) < 0
                     G.meshedCL(i,j) = G.meshedUG(i,j);
                 else
                     %Nothing
                 end
              end
           elseif G.totalUG(i<0)
               for j = 1:G.numofMG
                   if G.meshedUG(i,j)>0
                       G.meshedCL(i,j) = G.meshedUG(i,j);
                   else
                       %Nothing
                   end
               end
                  
           end
   end
end
