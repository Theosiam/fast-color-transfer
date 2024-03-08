% Demostration of Reinhard's Image Colour Transfer
%   References:
% Erik Reinhard, Michael Ashikhmin, Bruce Gooch and Peter Shirley,
% 'Color Transfer between Images', IEEE CG&A special issue on Applied
% Perception, Vol 21, No 5, pp 34-41, September - October 2001
% Copyright 2015 Han Gong, University of East Anglia
clear;
clc;
close all force
tic

SCORES=zeros(9,1);
SCORES_XIANG=zeros(9,1);
SCORES_XIAO=zeros(9,1);
for lala=10:18
lala

TRG = im2double(imread(strcat('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\',num2str(lala),'.png')));
SRC = im2double(imread(strcat('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\',num2str(lala-9),'.png')));
RI = uint8(cf_reinhard(TRG,SRC)*255);

%{
t=toc;
figure()
imshow(TRG); title('Original Image');
figure()
imshow(SRC); title('Source Image');
figure()
imshow(RI); title('Result After Colour Transfer');
%}


SCORES(lala)=CTQM(RI,uint8(TRG*255),uint8(SRC*255));
SCORES_XIANG(lala)=xiang_measure(RI,uint8(TRG*255),uint8(SRC*255));
SCORES_XIAO(lala)=xiao_measure(RI,uint8(TRG*255),uint8(SRC*255));
end
