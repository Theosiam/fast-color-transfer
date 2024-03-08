function [Final] = colored_clusters(img,means)
    img=rgb2lab(img);
    a=img(:,:,2);
    b=img(:,:,3);
    im_s=size(a);
    
    
    X=[a(:) b(:)];
    s=size(means);
    no_cl=s(1);
    
    Final=zeros(im_s(1),im_s(2));
    
    for i=1:im_s(1)
        for j=1:im_s(2)
            for k=1:no_cl
                D(k)=norm([a(i,j) b(i,j)]-means(k,:));
            end 
            index=find(D==min(D));
            Final(i,j)=index;
        end
    end
    Final=((Final-1)*255)/(no_cl-1);
    Final=uint8(Final);
    
end

