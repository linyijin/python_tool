function [] = mask2json(datapathmask,jsonExpandpath )

    dirOutput_mask = dir(fullfile(datapathmask,'*.png'));
    fileNames_mask = {dirOutput_mask.name}';
    if ~exist(jsonExpandpath)
       mkdir(jsonExpandpath);       % 若不存在，在当前目录中产生一个子目录‘Figure’
    end 

    number = size(fileNames_mask);

    for j = 1 : number(1)

        jj = find('.'==fileNames_mask{j,1});
        imname = fileNames_mask{j,1}(1:jj-1);

        im = imread([datapathmask, '\', fileNames_mask{j,1}]);
        imagefinal = im;
        imagefinal( find( imagefinal == 0)) = [];
        Finalclassname = unique(imagefinal);
        Finalclassname = Finalclassname';
        lenClassname = size(Finalclassname);
        shapes = [];
        Blength = [];
        Begin = 1;
        Bend = 0;
        for k = 1 : lenClassname(1)
            data = im;

            data(find(data > Finalclassname(k))) = 0;
            data(find(data < Finalclassname(k))) = 0;
            labelName = [];
            if Finalclassname(k) == 1
                labelName = 'baiban';
            end
            if Finalclassname(k) == 2
                labelName = 'podong';
            end
            if Finalclassname(k) == 3
                labelName = 'duanjing';
            end
            if Finalclassname(k) == 4
                labelName = 'zangban';
            end
            if Finalclassname(k) == 5
                labelName = 'zhici';
            end
            if Finalclassname(k) == 6
                labelName = 'cusha';
            end
            if Finalclassname(k) == 7
                labelName = 'shajie';
            end
            if Finalclassname(k) == 8
                labelName = 'xiaobandian';
            end
            if Finalclassname(k) == 9
                labelName = 'louyin';
            end
            if Finalclassname(k) == 10
                labelName = 'chousha';
			end
			if Finalclassname(k)==11
				labelName='sizheyin';
            end            
            data = data * 255;

            [B, L] = bwboundaries(data, 'noholes');          %寻找边缘，不包括孔
            BL = size(B);
            Blength = BL(1);

            Bend = Bend + Blength;

            for i = Begin : Bend
                datachange = B{i-Begin+1,1}(:, 1);
                B{i-Begin+1,1}(:, 1) = B{i-Begin+1,1}(:, 2);
                B{i-Begin+1,1}(:, 2) = datachange;
                shapes{i} = struct('label', labelName, 'points', B{i-Begin+1,1});
            end   
            Begin = Begin + Blength;
        end

        data2json.shapes = shapes;
        data2json.imagePath = [imname, '.jpg'];
        fprintf('小图json生成：%d,imname = %s\n' ,j, imname);
        savejson('', data2json, [jsonExpandpath, '\', imname, '.json']);

    end
    fprintf('-------------->>小图json制作完成<<--------------\n');