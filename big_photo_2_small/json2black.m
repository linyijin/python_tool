function [ ] = json2black( imgpath, jsonpath, maskpath)
    if ~exist(maskpath)
        mkdir(maskpath);       % 若不存在，在当前目录中产生一个子目录‘Figure’
    end
    dirOutput_json = dir(fullfile(jsonpath,'*.json'));
    fileNames_json = {dirOutput_json.name}';  
    number = size(fileNames_json);
    for j = 1 : number(1)
%         fileNames_json{j,1} = replace(fileNames_json{j,1},'.r0' ,'_r0');
%         fileNames_json{j,1} = replace(fileNames_json{j,1},'.r90' ,'_r90');
        jj = find('.'==fileNames_json{j,1});
        imname = fileNames_json{j,1}(1:jj-1);
        
        imgDate = [imgpath, '\', imname, '.bmp'];
        if ~exist(imgDate)
            imgDate= [imgpath, '\', imname, '.png'];
        end
        fprintf('原图mask生成:%d,imgDate = %s\n' ,j, imgDate);
        imgdata = imread(imgDate);

        [raw, col] = size(imgdata);
        col = col / 3;
        dat=loadjson([jsonpath, '\',fileNames_json{j, 1}]);
        image = uint8(ones(raw, col));
        classname = [];
    %     Image = [];
        classnumber = size(dat.shapes);
        imagefinal = uint8(zeros(raw, col));
%         flag = 0;
        for i = 1:classnumber(2)
    %         if strcmp(dat.shapes{1, i}.label, 'baiban')
    %             classname(i,1) = 1;
    %         end
    %         if strcmp(dat.shapes{1, i}.label, 'dase')
    %             classname(i,1) = 2;
    %         end
    %         if strcmp(dat.shapes{1, i}.label, 'louyin')
    %             classname(i,1) = 3;
    %         end
    %         if strcmp(dat.shapes{1, i}.label, 'shajie')
    %             classname(i,1) = 4;
    %         end
    %         if strcmp(dat.shapes{1, i}.label, 'banzhuang')
    %             classname(i,1) = 5;
    %         end
    %         if strcmp(dat.shapes{1, i}.label, 'dianzhuang')
    %             classname(i,1) = 6;
    %         end
    %         if strcmp(dat.shapes{1, i}.label, 'tiaosha')
    %             classname(i,1) = 7;
    %         end
    %         if strcmp(dat.shapes{1, i}.label, 'xiuhen')
    %             classname(i,1) = 8;
    %         end
    %         if strcmp(dat.shapes{1, i}.label, 'zhici')
    %             classname(i,1) = 9;
    %         end
    %         if strcmp(dat.shapes{1, i}.label, 'zhenyan')
    %             classname(i,1) = 10;
    %         end
    %         if strcmp(dat.shapes{1, i}.label, 'yichang')
    %            classname(i,1) = 11;
    %         end
    %         if strcmp(dat.shapes{1, i}.label, 'sedian')
    %             classname(i,1) = 12;
    %         end
    %         if strcmp(dat.shapes{1, i}.label, 'tiaozhuang')
    %             classname(i,1) = 13;
    %         end
    %         if strcmp(dat.shapes{1, i}.label, 'qianse')
    %             classname(i,1) = 14;
    %         end
             
            if strcmp(dat.shapes{1, i}.label, 'baiban')
                classname(i,1) = 1;
            elseif strcmp(dat.shapes{1, i}.label, 'podong')||strcmp(dat.shapes{1, i}.label, 'zhenyan')||strcmp(dat.shapes{1, i}.label, 'posun')
                classname(i,1) = 2;
            elseif strcmp(dat.shapes{1, i}.label, 'duanjing')
                classname(i,1) = 3;
            elseif strcmp(dat.shapes{1, i}.label, 'zangban')
                classname(i,1) = 4;
            elseif strcmp(dat.shapes{1, i}.label, 'zhici')
                classname(i,1) = 5; 
            elseif strcmp(dat.shapes{1, i}.label, 'cusha')
                classname(i,1) = 6;
            elseif strcmp(dat.shapes{1, i}.label, 'shajie')
                classname(i,1) = 7; 
            elseif strcmp(dat.shapes{1, i}.label, 'xiaobandian')
                classname(i,1) = 8; 
            elseif strcmp(dat.shapes{1, i}.label, 'louyin')
                classname(i,1) = 9; 
            elseif strcmp(dat.shapes{1, i}.label, 'gousi')
                classname(i,1) = 10; 
			elseif strcmp(dat.shapes{1,i}.label,'sizheyin')
				classname(i,1)=11;
            else
                classname(i,1) = 0;
                continue;
            end

%             image1 = image * classname(i,1);
            x = dat.shapes{1, i}.points(1:end, 1);
            y = dat.shapes{1, i}.points(1:end, 2);
            
            if strcmp(dat.shapes{1, i}.shape_type, 'rectangle')
                x = [x(1), x(1), x(2), x(2)];
                y = [y(1), y(2), y(2), y(1)];
            end
              
            BW1 = uint8(roipoly(image, x, y));
            
            image1 = BW1 * classname(i,1);
            
            dealimage = imagefinal;
            dealimage(imagefinal > 0) = 1;
            dealimage = dealimage + image1;
            if isempty(find(dealimage > classname(i,1))) == 0
                a = image1;
                a(dealimage <= classname(i,1)) = 0;
                a(dealimage > classname(i,1)) = classname(i,1);
                imagefinal = imagefinal + image1 - a; 
                flag = 1;
            else
                imagefinal = imagefinal + image1;
            end
            
%             Finalclassname = unique(classname);
%             imagedata = imagefinal;
%             imagedata(find( imagedata == 0)) = [];
%             imagedataclassname = unique(imagedata);
%             imagedataclassname = imagedataclassname';
% 
%             if ~isequal(Finalclassname, imagedataclassname)
%                 imagefinal(find(imagefinal >classname_max)) = classname_max;
%             end
            
        end
%         if flag == 1
           fileName2 = [maskpath, '\', imname,'.png'];
           imwrite(imagefinal, fileName2);   
%             flag = 0;
%         end
    end
    fprintf('----------->>原图mask制作完成<<------------\n');

