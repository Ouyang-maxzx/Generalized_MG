G.meshedUG = zeros(G.horizon, G.numofMG);
G.meshedCL = zeros(G.horizon, G.numofMG;)
for j = 1:G.numofMG
   G.meshedUG(:,j)  = MG_Group{j,1}.result2G(:,1);
end
pp = sign(G.meshedUG);
qq = sum(pp, 2);
G.totalUG = sum(G.meshedUG, 2);
G.totalUG
for i = 1:G.horizon
   switch qq(i,1)
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
