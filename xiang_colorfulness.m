function [E] = xiang_colorfulness(IMG)
    IMG=double(IMG);
    R=IMG(:,:,1);
    G=IMG(:,:,2);
    B=IMG(:,:,3);
    
    rg=R-G;
    yb=0.5*(R+G)-B;
    
    srg=std(rg(:));
    syb=std(yb(:));
    
    mrg=mean(rg(:));
    myb=mean(yb(:));
    
    E=sqrt((srg^2)+(syb^2))+0.3*sqrt((mrg^2)+(myb^2));
end

