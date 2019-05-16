function [ ] = spin45( othername, img, mask, angle, imgsavepath, datapathmask, instpath, binarypath, clspath ,slidwindow, overlapping, Markthreshold, txtpath, possamplesavepath, postxtpath)
%SPIN45 此处显示有关此函数的摘要
%   此处显示详细说明
    train = fopen(txtpath,'a');
    positive = fopen(postxtpath,'a');
    num = '001';
    
    width = int32(slidwindow(1)/overlapping);
    high = int32(slidwindow(2)/overlapping);
    imgR = imrotate(img,angle);
    
    mask(find(mask == 0)) = 255;
    maskR = imrotate(mask,angle);
    area255 = find(maskR == 255);
    area0 = find(maskR == 0);
    maskR(area255) = 0;
    maskR(area0) = 255;
    
    [r,c] = size(maskR);
    x_begin = 1;
    y_begin = 1;
    
    while (r - y_begin) > slidwindow(2)
        while (c - x_begin) > slidwindow(1)
       
            win = imcrop(maskR,[x_begin, y_begin, slidwindow(1)-1, slidwindow(2)-1]);
            area255 = find(win == 255);
            [aa,bb] = size(area255);
            if aa == 0
                areaNot0 = find(win>0);
                [x, y] = size(areaNot0);
                if x == 0                   
                    savename = strcat(othername, num);
                    cut_name = strcat(savename, '.jpg');
                    mask_cut_name = strcat(savename, '.png');
                    cut_imgsavename = strcat(imgsavepath,cut_name);
                    cut_masksavename = strcat(datapathmask,mask_cut_name);
                    cut_possampleimgsavename = strcat(possamplesavepath, cut_name);
                    cut_possamplemasksavename = strcat(possamplesavepath, mask_cut_name);
                    
                    fprintf(positive,'%s\n',savename);
                    img_cut = imcrop(imgR,[x_begin, y_begin, slidwindow(1)-1, slidwindow(2)-1]);
                    imwrite(img_cut, cut_possampleimgsavename);
%                     imwrite(win, cut_possamplemasksavename);
                    
                    
                    num = str2num(num)+1;
                    if num < 10
                        num = strcat('00', num2str(num));
                    elseif num < 100
                        num = strcat('0', num2str(num));
                    else
                        num = num2str(num);
                    end
                    
                
                elseif x > Markthreshold
                    savename = strcat(othername, num); 
                    areaInfo_1 = find(win == 1);
                    [Info_1_x, Info_1_y] = size(areaInfo_1);
                    areaInfo_2 = find(win == 2);
                    [Info_2_x, Info_2_y] = size(areaInfo_2);
                    areaInfo_3 = find(win == 3);
                    [Info_3_x, Info_3_y] = size(areaInfo_3);
                    areaInfo_4 = find(win == 4);
                    [Info_4_x, Info_4_y] = size(areaInfo_4);
                    areaInfo_5 = find(win == 5);
                    [Info_5_x, Info_5_y] = size(areaInfo_5);
                    areaInfo_6 = find(win == 6);
                    [Info_6_x, Info_6_y] = size(areaInfo_6);
                    areaInfo_7 = find(win == 7);
                    [Info_7_x, Info_7_y] = size(areaInfo_7);
					areaInfo_8 = find(win == 8);
                    [Info_8_x, Info_8_y] = size(areaInfo_8);
                    areaInfo_9 = find(win == 9);
                    [Info_9_x, Info_9_y] = size(areaInfo_9);
                    
                    if Info_1_x > 0
                        savename = strcat(savename ,'-','baiban');
                    end
                    if Info_2_x > 0
                        savename = strcat(savename,'-', 'podong');
                    end
                    if Info_3_x > 0
                        savename = strcat(savename,'-', 'duanjing');
                    end
                    if Info_4_x > 0
                        savename = strcat(savename,'-', 'zangban');
                    end
                    if Info_5_x > 0
                        savename = strcat(savename,'-', 'zhici');
                    end
                    if Info_6_x > 0
                        savename = strcat(savename,'-', 'cusha');
                    end
                    if Info_7_x > 0
                        savename = strcat(savename,'-', 'shajie');
                    end
					if Info_8_x > 0
                        savename = strcat(savename,'-', 'xiaobandian');
                    end
                    if Info_9_x > 0
                        savename = strcat(savename,'-', 'louyin');
                    end
                    
                    cut_name = strcat(savename, '.jpg');
                    mask_cut_name = strcat(savename, '.png');
                    cut_imgsavename = strcat(imgsavepath,cut_name);
                    cut_masksavename = strcat(datapathmask,mask_cut_name);
                    cut_possampleimgsavename = strcat(possamplesavepath, cut_name);
                    cut_possamplemasksavename = strcat(possamplesavepath, mask_cut_name);
                    
                    fprintf(train,'%s\n',savename);
                    img_cut = imcrop(imgR,[x_begin, y_begin, slidwindow(1)-1, slidwindow(2)-1]);
                    imwrite(img_cut, cut_imgsavename);
                    imwrite(win, cut_masksavename);
                    
%                   generalclsandinst( win, savename, instpath, binarypath, clspath)
                    

%                     flip_savename = strcat(savename, '_vertical');
%                     fprintf(train,'%s\n',flip_savename);
%                     flip_cut_name = strcat(othername, num, '_vertical','.jpg');
%                     flip_mask_cut_name = strcat(othername, num, '_vertical', '.png');
%                     flip_cut_imgsavename = strcat(imgsavepath,flip_cut_name);
%                     flip_cut_masksavename = strcat(masksavepath,flip_mask_cut_name);
%                     J1=flip(img_cut,1);%原图像的垂直镜像
%                     J2=flip(win,1);%原图像的垂直镜像
%                     imwrite(J1, flip_cut_imgsavename);
%                     imwrite(J2, flip_cut_masksavename);
%                     
%                     generalclsandinst( J2, flip_savename, instpath, binarypath, clspath)
%                     
%                     flip_savename = strcat(savename, '_horizontal');
%                     fprintf(train,'%s\n',flip_savename);
%                     flip_cut_name = strcat(othername, num, '_horizontal', '.jpg');
%                     flip_mask_cut_name = strcat(othername, num, '_horizontal', '.png');
%                     flip_cut_imgsavename = strcat(imgsavepath,flip_cut_name);
%                     flip_cut_masksavename = strcat(masksavepath,flip_mask_cut_name);
%                     J3=flip(img_cut,2);%原图像的水平镜像
%                     J4=flip(win,2);%原图像的水平镜像
%                     imwrite(J3, flip_cut_imgsavename);
%                     imwrite(J4, flip_cut_masksavename);
%                     
%                     generalclsandinst( J4, flip_savename, instpath, binarypath, clspath)
    
                    num = str2num(num)+1;
                    if num < 10
                        num = strcat('00', num2str(num));
                      
                    elseif num < 100
                        num = strcat('0', num2str(num));
                    else
                        num = num2str(num);
                    end
                else
                    num = str2num(num)+1;
                    num = num2str(num);
                end
            end
            x_begin = x_begin + width;
        end   
        x_begin = 1;
        y_begin = y_begin + high;        
    end
    
    fclose(train);
    fclose(positive);
end

