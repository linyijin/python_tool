% clc
% clear all
% ÎÄ¼þÂ·¾¶ÅäÖÃ
Dir = 'L:\20181116';
baiban1_Dir = [Dir,'\baiban_1'];
baiban2_Dir = [Dir,'\baiban_2'];
baiban3_Dir = [Dir,'\baiban_3'];
baiban4_Dir = [Dir,'\baiban_4'];
baiban5_Dir = [Dir,'\baiban_5'];
for i = 2:3
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
    end
    train_path = [detection_Dir, '\train\'];
    valid_path = [detection_Dir, '\valid\'];
    test_path = [detection_Dir, '\test\'];
    for j = 1:3
        if j==1
            data_rootpath = train_path;
        elseif j==2
            data_rootpath = valid_path;
        elseif j==3
            data_rootpath = test_path;
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
            end
            slidwindow = [imgSize, imgSize];
            imgSize_str = num2str(imgSize);
            txtpath = [data_rootpath,'\',imgSize_str,'\negList.txt'];
            postxtpath = [data_rootpath,'\',imgSize_str,'\posList.txt'];
            imgsavepath = [data_rootpath,'\',imgSize_str,'\img\'];
            datapathmask  = [data_rootpath,'\',imgSize_str,'\mask\'];
            jsonExpandpath  = [data_rootpath,'\',imgSize_str,'\json\'];
            possamplesavepath = [data_rootpath,'\',imgSize_str,'\posImg\'];
            instpath = [data_rootpath,'\',imgSize_str,'\inst\'];
            clspath = [data_rootpath,'\',imgSize_str,'\cls\'];
            binarypath = [data_rootpath,'\',imgSize_str,'\binary\'];

            Markthreshold = 300;
            % fp=fopen(strcat(rootpath,'train2.txt'),'wt');

            % overlapping = 3/2;
            overlapping = 1;
            angleInterval = 0;
            if k==1
                json2black(imgpath, jsonpath, maskpath);
            end
            spinandcutR45(imgSize,slidwindow,overlapping,angleInterval, Markthreshold, txtpath, postxtpath, imgpath, maskpath,imgsavepath, datapathmask, possamplesavepath,instpath,clspath, binarypath)
            mask2json(datapathmask,jsonExpandpath );
        end
    end
end