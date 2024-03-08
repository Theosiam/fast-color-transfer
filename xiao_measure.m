function [MSE] = xiao_measure(R,T,S)
    
    [CR,HIST_R]=imhist(R);
   
   
    [CS,HIST_S]=imhist(S);
    
    MSE_H=mse(CR,CS)/(10^10);
    
    resizeVal=300;
    R=imresize(R,[resizeVal,resizeVal]);
    T=imresize(T,[resizeVal,resizeVal]);
    R=double(rgb2gray(R));
    T=double(rgb2gray(T));
    R=sobel_filter(R);
    T=sobel_filter(T);
    MSE_G=mse(R,T)/100;
    
    L=1;
    MSE=MSE_H+L*MSE_G;
end

