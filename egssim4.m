function[ssimval] = egssim4(RL,TL)
    
    resizeVal=300;
    RL=imresize(RL,[resizeVal,resizeVal]);
    TL=imresize(TL,[resizeVal,resizeVal]);
    
    RL=ceil(rgb2lab(RL));
    TL=ceil(rgb2lab(TL));
    RL=double(RL);
    TL=double(TL);
    
    RL_nofilter=2.25*RL(:,:,1);
    TL_nofilter=2.25*TL(:,:,1);
    
    RL=sobel_filter(RL_nofilter);
    TL=sobel_filter(TL_nofilter);
    
    
    
    RL=double(RL(:,:,1));
    TL=double(TL(:,:,1));
    
    
    L=255;
    K1=0.005;
    K2=0.02;
    C1=(K1*L)^2;
    C2=(K2*L)^2;
    C3=C1/2;
    
    a=1;
    b=a;
    g=a;
    
    w=11;
    SS=0;
    k=w;
    N=0;
    while k < resizeVal-w
        j=w;
        while j < resizeVal-w 
            tRL=RL(k:k+w,j:j+w);
            tTL=TL(k:k+w,j:j+w);
            tRL_noF=RL_nofilter(k:k+w,j:j+w);
            tTL_noF=TL_nofilter(k:k+w,j:j+w);
            mx=mean(tRL_noF(:));
            my=mean(tTL_noF(:));
            sx=std(tRL(:));
            sy=std(tTL(:));  
            %NA TO DW AYURIO
            %{
            sxy=cov(tRL(:)',tTL(:)');
            sxy=mean(sxy(:));
            %}
            sxy=corr(tRL(:),tTL(:),'Type','Kendall');
            if isnan(sxy)
                sxy=0;
            end
            l=(2*mx*my+C1)/(mx^2+my^2+C1);
            c=(2*sx*sy+C2)/(sx^2+sy^2+C2);
            s=(sxy+C3)/(sx*sy+C3); 
            SS=SS+(l*c*s);           
            j=j+w;
            N=N+1;
        end
        k=k+w;
    end
    
    ssimval=SS/N;
    
    ssimval = ssim(RL,TL)
end