function [] = domain_colors(D1,p)
    
    Lavg=65;
    a=400;
    w=200;
    
    aD=[];
    bD=[];
    lD=[];
    for i=1:length(D1)
        h=ceil(p(i)*a);
        lD=[lD ; ones(h,w)*Lavg];
        aD=[aD ; ones(h,w)*D1(i,1)];
        bD=[bD ; ones(h,w)*D1(i,2)];
    end
     
    D=cat(3,lD,aD,bD);
    D=lab2rgb(D);
    
    figure()
    imshow(D)
    
end

