function[] = spinandcutR45(imgSize,slidwindow,overlapping,angleInterval,Markthreshold,txtpath, postxtpath, imgpath, maskpath,imgsavepath, datapathmask, possamplesavepath,instpath,clspath, binarypath)
% ��������ļ���
    if ~exist(imgsavepath)
        mkdir(imgsavepath);       % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��Figure��
    end 
    if ~exist(datapathmask)
        mkdir(datapathmask);       % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��Figure��
    end 
    if ~exist(instpath)
        mkdir(instpath);       % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��Figure��
    end 
    if ~exist(clspath)
        mkdir(clspath);       % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��Figure��
    end 
    if ~exist(binarypath)
        mkdir(binarypath);       % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��Figure��
    end
    if ~exist(possamplesavepath)
        mkdir(possamplesavepath);       % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��Figure��
    end 

    % ��ȡ
    dirOutput_mask = dir(fullfile(maskpath,'*.png'));
    fileNames_mask = {dirOutput_mask.name}';  
    number = size(fileNames_mask);
    
    for j = 1 : number(1)    
        jj = find('.'==fileNames_mask{j,1});
        imname = fileNames_mask{j,1}(1:jj-1);

        fprintf('��ͼ����%d,imname = %s\n', j, imname);

        
        imgDate = [imgpath, '\', imname, '.bmp'];
        if ~exist(imgDate)
            imgDate= [imgpath, '\', imname, '.png'];
        end
        maskDate= [maskpath, '\', imname, '.png'];
        img = imread(imgDate);
        mask = imread(maskDate);
        angle = 0;
    %     while angle<360
    %        othername = strcat(imname,'-r', num2str(angle) ,'-');
             othername = strcat(imname,'-');
             spin45(othername, img, mask, 360 - angle , imgsavepath, datapathmask, instpath, binarypath, clspath, slidwindow, overlapping, Markthreshold, txtpath, possamplesavepath, postxtpath);
    %         angle = angle + angleInterval;
    %     end
    
    end

   fprintf('----------->>%d*%dСͼ�ü����<<------------\n',imgSize,imgSize);
    


