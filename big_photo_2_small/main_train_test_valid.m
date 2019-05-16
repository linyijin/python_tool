clc
clear all
% ÎÄ¼þÂ·¾¶ÅäÖÃ
Dir = 'K:\shajie';
baiban1_Dir = [Dir,'\shajie-zizhi-all'];
baiban2_Dir = [Dir,'\zigouzizhi'];
baiban3_Dir = [Dir,'\dase'];
baiban4_Dir = [Dir,'\louyin'];
baiban5_Dir = [Dir,'\setiao'];
baiban6_Dir = [Dir,'\shajie'];
baiban7_Dir = [Dir,'\zangban'];

for i = 1:1
    if i==1
        detection_Dir = baiban1_Dir;
    elseif i==2
        detection_Dir = baiban2_Dir;
    elseif i==3
        detection_Dir = baiban3_Dir;
    elseif i==4
        detection_Dir = baiban4_Dir;
    elseif i==5
        detection_Dir = baiban5_Dir;
    elseif i==6
        detection_Dir = baiban6_Dir;
    elseif i==7
        detection_Dir = baiban7_Dir;
    end
    train_path = [detection_Dir, '\train\'];
    valid_path = [detection_Dir, '\valid\'];
    test_path = [detection_Dir, '\test\'];
    for j = 1:2
        if j==1
            data_rootpath = train_path;
        elseif j==2
            data_rootpath = test_path;
        elseif j==3
            data_rootpath = valid_path;
        end
        imgpath = [data_rootpath, 'origin'];
        jsonpath = [data_rootpath, 'origin'];
        maskpath = [data_rootpath, 'originmask'];

        %slidwindow = [600, 1000];
        for k = 1:1
            if k==1
                imgSize = 416;
            elseif k==2
                imgSize = 512;
            elseif k==3
                imgSize = 1024;
            end
            slidwindow = [imgSize, imgSize];
            imgSize_str = num2str(imgSize);
            txtpath = [data_rootpath,'\',imgSize_str,'\negList.txt'];
            postxtpath = [data_rootpath,'\',imgSize_str,'\posList.txt'];
            imgsavepath = [data_rootpath,'\',imgSize_str,'\img\'];
            datapathmask  = [data_rootpath,'\',imgSize_str,'\mask\'];
            jsonExpandpath  = [data_rootpath,'\',imgSize_str,'\json\'];
            possamplesavepath = [data_rootpath,'\',imgSize_str,'\posImg\'];
%             instpath = [data_rootpath,'\',imgSize_str,'\inst\'];
%             clspath = [data_rootpath,'\',imgSize_str,'\cls\'];
%             binarypath = [data_rootpath,'\',imgSize_str,'\binary\'];

            Markthreshold = 300;
            % fp=fopen(strcat(rootpath,'train2.txt'),'wt');

            % overlapping = 3/2;
            overlapping = 1;
            angleInterval = 0;
            if k==0
                json2black(imgpath, jsonpath, maskpath);
            end
%             spinandcutR45_Norm(imgSize,slidwindow,overlapping,angleInterval, Markthreshold, txtpath, postxtpath, imgpath, maskpath,imgsavepath, datapathmask, possamplesavepath)
            mask2json(datapathmask,jsonExpandpath );
        end
    end
end