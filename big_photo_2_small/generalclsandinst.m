function [ ] = generalclsandinst( mask, savename, instpath, binarypath, clspath)
%GENERALCLSANDINST 此处显示有关此函数的摘要
%   此处显示详细说明
    [row, col] = size(mask);
    imagefinal = mask;
    GTinst.Segmentation = zeros(row, col);
    GTinst.Boundaries = [];
    imagefinal( find( imagefinal == 0)) = [];
    Finalclassname = unique(imagefinal);
    Finalclassname = Finalclassname';
    lenClassname = size(Finalclassname);
    for k = 1 : lenClassname(1)
        data = mask;
        data(find(data > Finalclassname(k))) = 0;
        data(find(data < Finalclassname(k))) = 0;
        data(find(data == Finalclassname(k))) = k;
        GTinst.Segmentation = GTinst.Segmentation + double(data); 
    end  
    GTinst.Segmentation = double(GTinst.Segmentation);
    GTinst.Categories = Finalclassname;

    n = zeros(row, col);
    for k = 1 : 12
        GTcls.Boundaries{k, 1} = sparse(n);
    end
    for k = 1 : lenClassname(1)
        data = mask;
        data(find(data > Finalclassname(k))) = 0;
        data(find(data < Finalclassname(k))) = 0;
        data(find(data == Finalclassname(k))) = 1;
        data = double(data);
        GTcls.Boundaries{Finalclassname(k), 1} = sparse(data);
        GTinst.Boundaries{k, 1} = sparse(data);
    end
    GTcls.Segmentation = uint8(mask);
    GTcls.CategoriesPresent = Finalclassname;

    fileName = [instpath, savename, '.mat'];
    save(fileName, 'GTinst');
    fileName1 = [clspath, savename, '.mat'];
    save(fileName1, 'GTcls');
    blackimg = uint8(GTinst.Segmentation * 255);
    fileName2 = [binarypath, savename, '.jpg'];
    imwrite(blackimg, fileName2); 

end

