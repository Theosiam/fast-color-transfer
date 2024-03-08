function[E] = colorfulness(IMG)
    
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
    
    E=0.2*(log((srg^2)/(abs(mrg)^0.2)))*(log((syb^2)/(abs(myb)^0.2)));
    
end