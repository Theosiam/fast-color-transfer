clear;
clc;

src_pic=imread("C:\Users\Fanis\Desktop\DIPLOMA\sources\src1.png");
trg_pic=imread("C:\Users\Fanis\Desktop\DIPLOMA\targets\trg3.png");
T_before=rgb2lab(trg_pic);
L=T_before(:,:,1);
a=T_before(:,:,2);
b=T_before(:,:,3);

sampling_rate= 200/length(src_pic(:,:,1));
sampled_src_pic=imresize(src_pic,sampling_rate);

sampling_rate=200/length(trg_pic(:,:,1));
sampled_trg_pic=imresize(trg_pic,sampling_rate);

figure(1)
imshow(src_pic)
title('Source image')
figure(2)
imshow(trg_pic)
title('Target image')


src_lab_pic =(rgb2lab(sampled_src_pic));
trg_lab_pic =(rgb2lab(sampled_trg_pic));

L_src=src_lab_pic(:,:,1);
L_src_1d=L_src(:);
a_src=src_lab_pic(:,:,2);
a_src_1d=a_src(:);
b_src=src_lab_pic(:,:,3);
b_src_1d=b_src(:);

L_trg=trg_lab_pic(:,:,1);
L_trg_1d=L_trg(:);
a_trg=trg_lab_pic(:,:,2);
a_trg_1d=a_trg(:);
b_trg=trg_lab_pic(:,:,3);
b_trg_1d=b_trg(:);

X=[a_src_1d b_src_1d];

k=2;
[idx,C] = kmeans(X,k);
C_src=C;
C1=[];
C2=[];

for i=1:length(idx)
    if idx(i)==1
        C1=[C1 ;X(i,:)];
    else    
        C2=[C2 ;X(i,:)];
    end
end


src_means1=[mean(C1(:,1)) mean(C1(:,2))];
src_st_dev1=[std(C1(:,1)) std(C1(:,2))];

src_means2=[mean(C2(:,1)) mean(C2(:,2))];
src_st_dev2=[std(C2(:,1)) std(C2(:,2))];

% figure(3)
% plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
% hold on
% plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
% plot(C(:,1),C(:,2),'kx',...
%      'MarkerSize',15,'LineWidth',3) 
% legend('Cluster 1','Cluster 2','Centroids',...
%        'Location','NW')
% title 'Cluster Assignments and Centroids'
% hold off

% Lavg=mean2(L_src);
% 
% Lo=ones(200,200)*Lavg;
% D1a=ones(100,200)*C(1,1);
% D2a=ones(100,200)*C(2,1);
% Da=[D1a ; D2a];
% 
% D1b=ones(100,200)*C(1,2);
% D2b=ones(100,200)*C(2,2);
% Db=[D1b ; D2b];
% 
% D_C=cat(3,Lo,Da,Db);
% Domain_colours=lab2rgb(D_C);
% figure(4)
% imshow(Domain_colours)
% title('Domain Colours')

X2=[a_trg_1d b_trg_1d];

k=2;
[idx,C2] = kmeans(X2,k);
C_trg=C2;
C11=[];
C22=[];

for i=1:length(idx)
    if idx(i)==1
        C11=[C11 ;X2(i,:)];
    else    
        C22=[C22 ;X2(i,:)];
    end
end


trg_means1=[mean(C11(:,1)) mean(C11(:,2))];
trg_st_dev1=[std(C11(:,1)) std(C11(:,2))];

trg_means2=[mean(C22(:,1)) mean(C22(:,2))];
trg_st_dev2=[std(C22(:,1)) std(C22(:,2))];

L_recolored=L;

sizes=size(T_before);
a_recolored=zeros(sizes(1),sizes(2));
b_recolored=a_recolored;

for i=1:sizes(1)
    for j=1:sizes(2)       
        
        %Σε ποιον απο τους 2 κλαστερς της source ανοικει το pixel
        diff1=norm([a(i,j) b(i,j)]-[src_means1]);
        diff2=norm([a(i,j) b(i,j)]-[src_means2]);
        %Σε ποιον απο τους 2 κλαστερς της ταργετ ανοικει το pixel
        diff11=norm([a(i,j) b(i,j)]-[trg_means1]);
        diff22=norm([a(i,j) b(i,j)]-[trg_means2]);
       
        if diff1<diff2 %ανοικει στον 1
            
            if diff11<diff22 
                a_recolored(i,j)=((a(i,j)-trg_means1(1))/trg_st_dev1(1))+src_means1(1);
                b_recolored(i,j)=((b(i,j)-trg_means1(2))/trg_st_dev1(2))+src_means1(2);
            else
                a_recolored(i,j)=((a(i,j)-trg_means2(1))/trg_st_dev2(1))+src_means1(1);
                b_recolored(i,j)=((b(i,j)-trg_means2(2))/trg_st_dev2(2))+src_means1(2);
            end
        else
            
            if diff11<diff22
                a_recolored(i,j)=((a(i,j)-trg_means1(1))/trg_st_dev1(1))+src_means2(1);
                b_recolored(i,j)=((b(i,j)-trg_means1(2))/trg_st_dev1(2))+src_means2(2);
            else
                a_recolored(i,j)=((a(i,j)-trg_means2(1))/trg_st_dev2(1))+src_means2(1);
                b_recolored(i,j)=((b(i,j)-trg_means2(2))/trg_st_dev2(2))+src_means2(2);
            end            
        end       
    end
end            
            
final=cat(3,L,a_recolored,b_recolored);
finall=lab2rgb(final);

figure(5)
imshow(finall)
title('RECOLORED IMAGE')
       




