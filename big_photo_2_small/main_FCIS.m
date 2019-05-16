clc
clear all
% ÎÄ¼þÂ·¾¶ÅäÖÃ
data_rootpath = 'K:\1-luolaizhenshi\0ckeck0\baiban\test\';
imgpath = [data_rootpath, 'origin'];
jsonpath = [data_rootpath, 'origin'];
maskpath = [data_rootpath, 'originmask'];

%slidwindow = [600, 1000];
imgSize = 416;
slidwindow = [imgSize, imgSize];
txtpath = [data_rootpath,'negList.txt'];
postxtpath = [data_rootpath,'posList.txt'];

imgsavepath = [data_rootpath,'img\'];
datapathmask  = [data_rootpath,'mask\'];
jsonExpandpath  = [data_rootpath,'json\'];
possamplesavepath = [data_rootpath,'posImg\'];
instpath = [data_rootpath, 'inst\'];
clspath = [data_rootpath, 'cls\'];
binarypath = [data_rootpath,'binary\'];
Markthreshold = 300;
% fp=fopen(strcat(rootpath,'train2.txt'),'wt');

% overlapping = 3/2;
overlapping = 1;
angleInterval = 0;

json2black(imgpath, jsonpath, maskpath);
spinandcutR45(imgSize,slidwindow,overlapping,angleInterval, Markthreshold, txtpath, postxtpath, imgpath, maskpath,imgsavepath, datapathmask, possamplesavepath,instpath,clspath, binarypath)
mask2json(datapathmask,jsonExpandpath );