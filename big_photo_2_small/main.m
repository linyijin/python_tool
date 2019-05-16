clc
clear all
% 文件路径配置
data_rootpath = 'C:\Users\Administrator\Desktop\20190401GOUSI\20190401\20190401CR\';
imgpath = [data_rootpath, 'img'];
jsonpath = [data_rootpath, 'json'];
maskpath = [data_rootpath, 'originmask'];

%slidwindow = [600, 1000];
imgSize = 416;
slidwindow = [imgSize, imgSize];
txtpath = [data_rootpath,'negList.txt'];
postxtpath = [data_rootpath,'posList.txt'];

imgSize_str = num2str(imgSize);
txtpath = [data_rootpath,'\',imgSize_str,'\negList.txt'];
postxtpath = [data_rootpath,'\',imgSize_str,'\posList.txt'];
imgsavepath = [data_rootpath,'\',imgSize_str,'\img\'];
datapathmask  = [data_rootpath,'\',imgSize_str,'\mask\'];
jsonExpandpath  = [data_rootpath,'\',imgSize_str,'\json\'];
possamplesavepath = [data_rootpath,'\',imgSize_str,'\posImg\'];
%instpath = [data_rootpath,'\',imgSize_str,'\inst\'];
%clspath = [data_rootpath,'\',imgSize_str,'\cls\'];
%binarypath = [data_rootpath,'\',imgSize_str,'\binary\'];

Markthreshold = 10; %mask的ROI面积阈值
% fp=fopen(strcat(rootpath,'train2.txt'),'wt');

% overlapping = 3/2;
overlapping = 1;
angleInterval = 0;

json2black(imgpath, jsonpath, maskpath);
spinandcutR45_Norm(imgSize,slidwindow,overlapping,angleInterval, Markthreshold, txtpath, postxtpath, imgpath, maskpath,imgsavepath, datapathmask, possamplesavepath)
mask2json(datapathmask,jsonExpandpath );