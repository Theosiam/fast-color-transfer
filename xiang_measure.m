function [measure] = xiang_measure(R,T,S)
    A4=1;
    CS=abs(xiang_colorfulness(R)-xiang_colorfulness(S));
    
    resizeVal=300;
    R=imresize(R,[resizeVal,resizeVal]);
    T=imresize(T,[resizeVal,resizeVal]);
    gR=rgb2gray(R);
    gT=rgb2gray(T);
    
    w=10;
    bhma=10;
    k=w;
    N=0;
    SS=0;
    while k < resizeVal-w
        j=w;
        while j < resizeVal-w 
            tRL=gR(k:k+w,j:j+w);
            tTL=gT(k:k+w,j:j+w);
            SS=SS+gssim(tRL,tTL);
            j=j+bhma;
            N=N+1;
        end
        k=k+bhma;
    end
    SS=SS/N;
    
    measure=(SS+A4)/(CS+A4);
    
    
end

