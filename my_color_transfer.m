clear;
clc;
close all force

trg=imread(strcat('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\4.png'));
src=imread(strcat('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\16.png'));

old_trg=trg;

figure()
imshow(src)
title('Source image')
figure()
imshow(trg)
title('Target image')

[labels_trg,N_trg]=superpixels(trg,2500,'NumIterations',300,'Method','slic','Compactness',5);
[labels_src,N_src]=superpixels(src,10);

Strg=size(trg);
Ssrc=size(src);

trg=rgb2lab(trg);
L_trg=trg(:,:,1);
a_trg=trg(:,:,2);
b_trg=trg(:,:,3);
oldL=L_trg;
k=L_trg;
k(k>85)=100;
k(k<15)=0;
k=uint8(2.25*k);

figure()
imshow(k)

meanLtrg=zeros(N_trg,1);
meanAtrg=zeros(N_trg,1);
meanBtrg=zeros(N_trg,1);
stdAtrg=zeros(N_trg,1);
stdBtrg=zeros(N_trg,1);
for i=1:N_trg
    meanAtrg(i)=mean(a_trg(find(labels_trg==i)));
    meanBtrg(i)=mean(b_trg(find(labels_trg==i)));
    stdAtrg(i)=std(a_trg(find(labels_trg==i)));
    stdBtrg(i)=std(b_trg(find(labels_trg==i)));
    
    
    meanLtrg(i)=mean(L_trg(find(labels_trg==i)));
end

meansTRG=[meanAtrg meanBtrg];
stdTRG=[stdAtrg stdBtrg];

for i=1:Strg(1)
    for j=1:Strg(2)
        
        a_trg(i,j)=meanAtrg(labels_trg(i,j));
        b_trg(i,j)=meanBtrg(labels_trg(i,j));
        L_trg(i,j)=meanLtrg(labels_trg(i,j));
    end
end



Rtrg=cat(3,L_trg,a_trg,b_trg);
Rtrg=lab2rgb(Rtrg);
figure
imshow(Rtrg)

M=120;
src=img_sampling(src,M);


[mS,sS]=k_means_opt_lab_Image(rgb2lab(src));
s_mS=size(mS);
M=zeros(N_trg,3);
for i=1:N_trg
    temp=zeros(s_mS(1),1);
    for j=1:s_mS(1)
        temp(j)=norm(meansTRG(i,:)-mS(j,:));        
    end
    [min_val,index]=min(temp);
    M(i)=index;   
end

a=zeros(Strg(1),Strg(2));
b=a;

for i=1:Strg(1)
    for j=1:Strg(2)
        index=labels_trg(i,j);
        a(i,j)=(sS(M(index),1)/stdTRG(index,1))*(a_trg(i,j)-meansTRG(index,1))+mS(M(index),1);
        b(i,j)=(sS(M(index),2)/stdTRG(index,2))*(b_trg(i,j)-meansTRG(index,2))+mS(M(index),2);
    end
end

Final=cat(3,oldL,a,b);
figure()
Final=lab2rgb(Final);
imshow(Final)

[L,N]=superpixels(old_trg,2500,'NumIterations',300,'Method','slic','Compactness',5);
figure()
BW = boundarymask(L);
imshow(imoverlay(Final,BW,'cyan'),'InitialMagnification',100)
