function [M] = color_matching(mS,mT)
   
    len_mS=length(mS(:,1));
    len_mT=length(mT(:,1));
    M=zeros(len_mT,1);
    
    Distances=zeros(len_mT,len_mS);
    for i=1:len_mT
       for j=1:len_mS 
         D=norm(mS(j,:)-mT(i,:));
         Distances(i,j)=D;
       end
    end
    %
   
    %
    mS_counter=zeros(1,len_mS);
    th=ceil(len_mT/len_mS);
    i=1;
    while i<=len_mT
        [a b]=find(Distances==min(Distances(:)));
        if mS_counter(b)< th
            Distances(a,:)=1000;
            mS_counter(b)=mS_counter(b)+1;
            M(a)=b;
            i=i+1;
        else
            Distances(:,b)=1000;
            
        end
        
    end
    
end