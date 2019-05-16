import xml.etree.ElementTree as ET
import pickle
import os, sys
from os import listdir, getcwd
from os.path import join
from xml.dom.minidom import parse
import xml.dom.minidom
import numpy as np
from scipy import stats
s=[]
classes = ['shajie']
# classes = ['cusha']
def mkdir(path):
    path = path.strip()
    path = path.rstrip("\\")
    isExists = os.path.exists(path)
    if not isExists:
        os.makedirs(path)
def convert(size, box):
    dw = 1. / size[0]
    dh = 1. / size[1]
    x = (box[0] + box[1]) / 2.0
    y = (box[2] + box[3]) / 2.0
    w = box[1] - box[0]
    h = box[3] - box[2]
    x = x 
    w = w 
    y = y 
    h = h 
    return x, y, w, h


def convert_annotation(file_path):
    #in_path = file_path.replace('.jpg', '.xml')
    in_path=file_path
    (tmp_path, file_name) = os.path.split(in_path)#����·�����ļ���
    xml_path = tmp_path + '/' + file_name#xml�ļ���
    #print(txt_outfile)
    #print(xml_path)

    in_file = open(xml_path)
    tree = ET.parse(in_file)#����xml���ṹ
    root = tree.getroot()
    size = root.find('size')
    w = int(size.find('width').text)
    h = int(size.find('height').text)
    for obj in root.iter('object'):
        cls = obj.find('name').text
        if cls not in classes:#ÿ��Ҫ��������
            continue
        cls_id = classes.index(cls)
        xmlbox = obj.find('bndbox')
        b = (float(xmlbox.find('xmin').text), float(xmlbox.find('xmax').text), float(xmlbox.find('ymin').text),
                float(xmlbox.find('ymax').text))
        bb = convert((w, h), b)
        s.append(bb[2]*bb[3])
        


path = r'C:\\Users\\lion\\Desktop\\xml\\shajie\\train\\'

for root, dirs, files in os.walk(path):
    for image_id in files:
        if image_id.endswith('.xml'):
            file_path = path + "/" + image_id
            convert_annotation(file_path)
txt_path=path+'count.txt'
f=open(txt_path,'w')
f.write(str(s))
f.close()

score=[]
for i in s:
    score.append(i)
print("前三众数为")
print(stats.mode(score)[0][0])
for i in score:
    score.remove(stats.mode(score)[0][0])
print(stats.mode(score)[0][0])
for i in score:
    score.remove(stats.mode(score)[0][0])
print(stats.mode(score)[0][0])

print("最大值")
print(max(s))
print("最小值")
print(min(s))
print("样本数量")
print(len(s))
print("均值")
print(np.mean(s))
import matplotlib.pyplot as plt
plt.figure("count")
plt.hist(s,bins=256)
plt.title('shajie train')
plt.ylabel('count',rotation=45)
plt.xlabel('area size')
plt.show()