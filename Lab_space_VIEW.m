L=ones(256,256)*70;
a=zeros(256,256);
b=a;
for i=1:256
    for j=1:256
        a(i,j)=127-i;
        b(i,j)=j-129;
    end
end

R=cat(3,L,a,b);
R=lab2rgb(R);  
imshow(R)