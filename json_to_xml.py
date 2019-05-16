# 脚本功能：从指定文件夹中，根据子文件夹(json)中的json文件转换成子文件夹(xml)的xml文件，修正bbox超界问题
# 作者：卓智强
# 时间：20190129
import json
import xml.dom.minidom as md
from PIL import Image
import os
import io

def mkdir(path):
    path = path.strip()
    path = path.rstrip("\\")

    isExists = os.path.exists(path)

    if not isExists:
        os.makedirs(path)

foldername='VOC2007'
def jsontoxml(path):
    rootpath = path.replace(".json", "")
    print(rootpath)
    f = io.open(rootpath+".json", 'r', encoding='gbk')  
    setting = json.load(f)
    family = setting['shapes']
    img = Image.open(rootpath.replace('json', 'img') + ".jpg")

    wide = str(img.size[0])
    high = str(img.size[1])
    imgname = setting['imagePath']
    print(img.size)
    print(imgname)

    xmlfile = md.Document()
    annotation = xmlfile.createElement('annotation')
    xmlfile.appendChild(annotation)

    folder = xmlfile.createElement('folder')
    folder.appendChild(xmlfile.createTextNode(foldername))
    annotation.appendChild(folder)

    filename = xmlfile.createElement('filename')
    filename.appendChild(xmlfile.createTextNode(imgname))
    annotation.appendChild(filename)

    source = xmlfile.createElement('source')
    database = xmlfile.createElement('database')
    database.appendChild(xmlfile.createTextNode('The VOC2007 Database'))
    source.appendChild(database)
    source_annotation = xmlfile.createElement('annotation')
    source_annotation.appendChild(xmlfile.createTextNode('PASCAL VOC2007'))
    source.appendChild(source_annotation)
    image = xmlfile.createElement('image')
    image.appendChild(xmlfile.createTextNode('flickr'))
    source.appendChild(image)
    flickrid = xmlfile.createElement('flickrid')
    flickrid.appendChild(xmlfile.createTextNode('NULL'))
    source.appendChild(flickrid)
    annotation.appendChild(source)

    owner = xmlfile.createElement('owner')
    flickrid = xmlfile.createElement('flickrid')
    flickrid.appendChild(xmlfile.createTextNode('NULL'))
    owner.appendChild(flickrid)
    name = xmlfile.createElement('name')
    name.appendChild(xmlfile.createTextNode('ruijie'))
    owner.appendChild(name)
    annotation.appendChild(owner)

    size = xmlfile.createElement('size')
    annotation.appendChild(size)
    width = xmlfile.createElement('width')
    size.appendChild(width)
    xmlcontent = xmlfile.createTextNode(wide)
    width.appendChild(xmlcontent)
    height = xmlfile.createElement('height')
    size.appendChild(height)
    xmlcontent = xmlfile.createTextNode(high)
    height.appendChild(xmlcontent)
    depth = xmlfile.createElement('depth')
    size.appendChild(depth)
    xmlcontent = xmlfile.createTextNode('3')
    depth.appendChild(xmlcontent)

    segmented = xmlfile.createElement('segmented')
    segmented.appendChild(xmlfile.createTextNode(str(0)))
    annotation.appendChild(segmented)

    for text in family:
        label = text['label']
        print("label:"+label)  
        points = text['points']
        xmin1 = 10000
        ymin1 = 10000
        xmax1 = 0
        ymax1 = 0
        for point in points:

            if xmin1 > point[0]:
                xmin1 = point[0]
            if ymin1 > point[1]:
                ymin1 = point[1]
            if xmax1 < point[0]:
                xmax1 = point[0]
            if ymax1 < point[1]:
                ymax1 = point[1]
            
            if xmin1 < 0:
                xmin1 = 0
            if ymin1 < 0:
                ymin1 = 0
            
            if xmax1 >= int(wide):
                xmax1 = int(wide) -1
            
            if ymax1 >= int(high):
                ymax1 = int(high) -1

        object = xmlfile.createElement('object')
        annotation.appendChild(object)
        name = xmlfile.createElement('name')
        object.appendChild(name)
        xmlcontent = xmlfile.createTextNode(label)
        name.appendChild(xmlcontent)

        pose = xmlfile.createElement('pose')
        pose.appendChild(xmlfile.createTextNode('Unspecified'))
        object.appendChild(pose)
        truncated = xmlfile.createElement('truncated')
        truncated.appendChild(xmlfile.createTextNode(str(0)))
        object.appendChild(truncated)

        difficult = xmlfile.createElement('difficult')
        object.appendChild(difficult)
        xmlcontent = xmlfile.createTextNode('0')
        difficult.appendChild(xmlcontent)

        bndbox = xmlfile.createElement('bndbox')
        object.appendChild(bndbox)
        xmin = xmlfile.createElement('xmin')
        bndbox.appendChild(xmin)
        xmlcontent = xmlfile.createTextNode(str(xmin1))
        xmin.appendChild(xmlcontent)

        xmax = xmlfile.createElement('xmax')
        bndbox.appendChild(xmax)
        xmlcontent = xmlfile.createTextNode(str(xmax1))
        xmax.appendChild(xmlcontent)

        ymin = xmlfile.createElement('ymin')
        bndbox.appendChild(ymin)
        xmlcontent = xmlfile.createTextNode(str(ymin1))
        ymin.appendChild(xmlcontent)

        ymax = xmlfile.createElement('ymax')
        bndbox.appendChild(ymax)
        xmlcontent = xmlfile.createTextNode(str(ymax1))
        ymax.appendChild(xmlcontent)

    rootpath = rootpath+'.xml'
    rootpath = rootpath.replace('json', 'xml')
    (xml_path, xml_name) = os.path.split(rootpath)
    mkdir(xml_path)
    print(rootpath)
    with open(rootpath, 'wb') as f:
        f.write(xmlfile.toprettyxml(encoding = 'utf-8'))
    return 0


def main():
    root_path = r'C:\Users\Administrator\Desktop\20190401GOUSI\20190318\20190318gousiCR\416'
    Dir = root_path
    json_path = Dir + r'\json'

    for root, dirs, files in os.walk(json_path):
        for file in files:
            if file.endswith('.json'):
                print("path:"+file)
                jsontoxml(json_path+'/'+file)


if __name__ == '__main__':
    main()
    print("done!")
