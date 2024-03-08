clear;
clc;
close all force
SCORES=zeros(9,1);
SCORES_XIANG=zeros(9,1);
SCORES_XIAO=zeros(9,1);

%Είσαγωγή εικόνων και εμφάνιση αυτών.(set Image path)
trg_pic=imread(strcat('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\6.png'));
src_pic=imread(strcat('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\54.jpg'));

figure()
imshow(src_pic)
title('Source image')
figure()
imshow(trg_pic)
title('Target image')

%Samppling των εικόνων, οπου M το επιθυμητό μέγεθος πλάτους της
%sampled εικόνας.

M=120;
sampled_src_pic=img_sampling(src_pic,M);
sampled_trg_pic=img_sampling(trg_pic,M);

%{
figure()
imshow(sampled_src_pic);
%}

rgbT_I=sampled_trg_pic;
rgbS_I=sampled_src_pic;

%Μετατροπή των εικόνων sampled εικόνων σε L*α*β* μορφή.
src_lab_pic =(rgb2lab(sampled_src_pic));
trg_lab_pic =(rgb2lab(sampled_trg_pic));

%Clustering και εξαγωγή των χαρακτηριστικών mS,σS,mT,σT.
[mS,sS,kS,pS]=k_means_opt_lab_Image(src_lab_pic);
[mT,sT,kT,pT]=k_means_opt_lab_Image(trg_lab_pic);

%Εμφάνιση των clusters με βάση το χρώμα
%{
colored_clusters(src_pic,mS);
%}

%

%Εφάνιση των κυρίαρχων χρωμάτων για την κάθε εικόνα (Source & Target 
%Domain Colors)


domain_colors(mS,pS);
title('Domain Colors of Source')
domain_colors(mT,pT);
title('Domain Colors of Target')


%Αναχρωματισμός της εικόνας στόχου (target) και εμφάνιση αυτής.


R_I=color_transfer(trg_pic,mS,mT,sT,sS,pS,pT);
R_I=uint8(R_I*255);

figure()
imshow(R_I);

title('Recolored Image (Result)')


%Υπολογισμός δείκτη ποιότητας του αλγορίθμου μεταφοράς χρώματος
SCORES(1)=CTQM(R_I,trg_pic,src_pic);
SCORES_XIANG(1)=xiang_measure(R_I,trg_pic,src_pic);
SCORES_XIAO(1)=xiao_measure(R_I,trg_pic,src_pic);

%{
trg_pic=rgb2lab(trg_pic);
l=trg_pic(:,:,1);
l=ceil(l);
l=uint8(l);
figure()
imshow(l);
%}

