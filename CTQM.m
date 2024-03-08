function [score] = CTQM(R,T,S)
    %R,T,S inputs as RGB values
    
    wm=0.001;
    wo=0.35;
    ws=5.3;
    
    Eo=colorfulness(R);
    Em=color_map_similarity(R,S);
    
    resizeVal=300;
    R=imresize(R,[resizeVal,resizeVal]);
    T=imresize(T,[resizeVal,resizeVal]);
    
    R=rgb2lab(R);  
    R_L=double(2.55*R(:,:,1));
    
    T=rgb2lab(T);    
    T_L=double(2.55*T(:,:,1));
    %Εφαρμογη του gssim ανα παραθυρα
    
    w=10;
    bhma=10;
    k=w;
    N=0;
    Es=0;
    while k < resizeVal-w
        j=w;
        while j < resizeVal-w 
            tRL=R_L(k:k+w,j:j+w);
            tTL=T_L(k:k+w,j:j+w);
            Es=Es+gssim(tRL,tTL);
            j=j+bhma;
            N=N+1;
        end
        k=k+bhma;
    end
    Es=Es/N;
    score=2+wo*Eo+wm*Em+ws*Es;
end

