% Demostration of Xiao's Image Colour Transfer
% Copyright 2015 Han Gong <gong@fedoraproject.org>, University of East
% Anglia.
% References:
% Xiao, Xuezhong, and Lizhuang Ma. "Color transfer in correlated color
% space." % In Proceedings of the 2006 ACM international conference on
% Virtual reality continuum and its applications, pp. 305-309. ACM, 2006.
clear;
clc;
close all force
tic;

SCORES=zeros(9,1);
SCORES_XIANG=zeros(9,1);
SCORES_XIAO=zeros(9,1);
for lala=10:18
lala

TRG = im2double(imread(strcat('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\',num2str(lala),'.png')));
SRC = im2double(imread(strcat('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\',num2str(lala-9),'.png')));
RI = uint8(cf_Xiao06(TRG,SRC)*255);
t=toc;

%{
figure; 
imshow(TRG); title('Original Image'); 
figure;
imshow(SRC); title('Source Image'); 
figure;
imshow(RI); title('Result After Colour Transfer'); 
%}

SCORES(lala)=CTQM(RI,uint8(TRG*255),uint8(SRC*255));
SCORES_XIANG(lala)=xiang_measure(RI,uint8(TRG*255),uint8(SRC*255));
SCORES_XIAO(lala)=xiao_measure(RI,uint8(TRG*255),uint8(SRC*255));
end
