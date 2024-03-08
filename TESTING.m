%mS=[[(mS+128)/(255)] pS]
%mT=[[(mT+128)/(255)] pT]

dS_temp=1000
 for l=1:2
                dS=norm(mS(l,:)-mT(2,:))
                if dS<dS_temp
                    dS_temp=dS;
                    idxS=l;
                end    
 end
 idxS        