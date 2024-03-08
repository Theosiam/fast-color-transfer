function[H] = hist_2D_ab(IMG)
        
    a=IMG(:,:,2);
    b=IMG(:,:,3);
    a=imresize(a,[80,80]);
    b=imresize(b,[80,80]);
    a=ceil(a);
    b=ceil(b);
       
    V=int8([a(:) b(:)]);
    w=length(V);
    H=zeros(251,251);
    for i=-125:125
        for j=-125:125
            t=length(find(V(:,1)==i & V(:,2)==j ));
            p=t;
            H(i+126,j+126)=p;            
        end
    end
    
    %{
    mx=max(H(:));
    mn=min(H(:));
    Hshow=255+((H-mn)*(0-255))/(mx-mn);
    Hshow=uint8(Hshow);
    figure
    imshow(Hshow)
    %}
    H=uint8(H);
    
    
end