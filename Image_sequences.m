clear;
clc;
close all force

%Reading images
src1=imread("C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\white.jpg");
src3=imread("C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\green.png");
src2=imread("C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\red.png");

trg=imread("C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\19.png");

figure()
subplot(1,4,1), imshow(src1)
subplot(1,4,2), imshow(src3)
subplot(1,4,3), imshow(src2)
subplot(1,4,4), imshow(trg)

1
%Down-Sampling Images
M=100;
src1_sampled=img_sampling(src1,M);
src2_sampled=img_sampling(src3,M);
src3_sampled=img_sampling(src2,M);
trg_sampled=img_sampling(trg,M);
2

%Converting sampled images to CIElαβ
src1_sampled =rgb2lab(src1_sampled);
src2_sampled =rgb2lab(src2_sampled);
src3_sampled =rgb2lab(src3_sampled);
trg_sampled =rgb2lab(trg_sampled);
3
%Clustering και εξαγωγή των χαρακτηριστικών mS,σS,mT,σT.
[m1,s1,k1,p1]=k_means_opt_lab_Image(src1_sampled);
[m2,s2,k2,p2]=k_means_opt_lab_Image(src2_sampled);
[m3,s3,k3,p3]=k_means_opt_lab_Image(src3_sampled)
[mT,sT,kT,pT]=k_means_opt_lab_Image(trg_sampled);
4
%Εξαγωγή της συνάρτησης color-matching
M1=color_matching(m1,mT);
M2=color_matching(m2,mT);
M3=color_matching(m3,mT);
5
trg=rgb2lab(trg);

L=trg(:,:,1);
a=trg(:,:,2);
b=trg(:,:,3);

sizes=size(trg);

N=15;
M=3;

a_rec=zeros(sizes(1),sizes(2),N);

b_rec=a_rec;

for ii=1:sizes(1)       
    for jj=1:sizes(2)
                        
            dT_temp=1000;
            idxT=1;
            X=[a(ii,jj) b(ii,jj)];
            
            Len=size(mT);           
            for l=1:Len(1)  
                
                dT=norm(X-mT(l,:));
                if dT<dT_temp
                    dT_temp=dT;
                    idxT=l;
                end    
            end
            
            idxS1=M1(idxT);
            idxS2=M2(idxT);
            idxS3=M3(idxT);
            
          
            for j=1:M
                m=(((m2(idxS2,:)-m1(idxS1,:))/(M-1))*(j-1))+m1(idxS1,:);
                s=(((s2(idxS2,:)-s1(idxS1,:))/(M-1))*(j-1))+s1(idxS1,:);
                a_rec(ii,jj,j)=(s(1)/sT(idxT,1))*(a(ii,jj)-mT(idxT,1))+m(1);
                b_rec(ii,jj,j)=(s(2)/sT(idxT,2))*(b(ii,jj)-mT(idxT,2))+m(2);
                
            end 
            
            for j=M+1:N
                m=(((m2(idxS2,:)-m3(idxS3,:))/(M-N))*(j-M))+m2(idxS2,:);
                s=(((s2(idxS2,:)-s3(idxS3,:))/(M-N))*(j-N))+s2(idxS2,:);
                a_rec(ii,jj,j)=(s(1)/sT(idxT,1))*(a(ii,jj)-mT(idxT,1))+m(1);
                b_rec(ii,jj,j)=(s(2)/sT(idxT,2))*(b(ii,jj)-mT(idxT,2))+m(2);                
            end  
            
    end
end  
    

figure()
for i=1:N
    final=cat(3,L,a_rec(:,:,i),b_rec(:,:,i));
    final=lab2rgb(final);
    
    subplot(3,5,i), imshow(final)
    %imwrite(final,strcat('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\matlabexported\neo',num2str(i),'.png'));
end



