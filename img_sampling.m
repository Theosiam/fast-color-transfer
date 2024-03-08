function [s_img] = img_sampling(img,M)
   
    sizes=size(img(:,:,1));
    rate=ceil(sizes(1)/M);
    k=0;    
    for i=1:rate:sizes(1)
        k=k+1;
        l=0;
        
        for j=1:rate:sizes(2)
            l=l+1;
            s_img(k,l,1)=img(i,j,1);
            s_img(k,l,2)=img(i,j,2);
            s_img(k,l,3)=img(i,j,3);
        end
    end
    
end

