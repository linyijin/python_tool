import xml.etree.ElementTree as ET
import os, sys
from xml.dom.minidom import parse
import xml.dom.minidom
import shutil
def convertChoushaToGousi(xmlPath):
    inFile=open(xmlPath)
    tree=ET.parse(inFile)
    root=tree.getroot()
    findGousi=False
    for obj in root.iter('object'):
        if obj.find('name').text=="gousi":
            findGousi=True
    for obj in root.iter('object'):
        if obj.find('name').text=="shajie":
            if findGousi==True:
                return 1
            else:
                return 2
    for obj in root.iter('object'):
        if obj.find('name').text=="podong":
            if findGousi==True:
                return 3
            else:
                return 4
imgPath="C:/Users/Administrator/Desktop/zzq/duansha/train/img"
if not os.path.exists(imgPath+'/'+'shajie'):
    os.mkdir(imgPath+'/'+'shajie')
if not os.path.exists(imgPath+'/'+'podong'):
    os.mkdir(imgPath+'/'+'podong')
for root,dirs,files in os.walk(imgPath):
    for img in files:
        if img.endswith('.xml'):
            xmlPath=imgPath+'/'+img
            result=convertChoushaToGousi(xmlPath)
            if result!=0:
                (imgName,imgType)=os.path.splitext(img)
                print(imgName)
                imgNameFile=imgName+'.jpg'
                xmlNameFile=imgName+'.xml'
                print(imgNameFile)
                print(xmlNameFile)
                if result==1:#shajie复制处理
                    print("1")
                    shutil.copy(imgPath+'/'+imgNameFile,imgPath+'/'+'shajie'+'/'+imgNameFile)
                    shutil.copy(imgPath+'/'+img,imgPath+'/'+'shajie'+'/'+xmlNameFile)
                elif result==2:#shajie剪切处理
                    print("2")
                    shutil.move(imgPath+'/'+imgNameFile,imgPath+'/'+'shajie'+'/'+imgNameFile)
                    shutil.move(imgPath+'/'+img,imgPath+'/'+'shajie'+'/'+xmlNameFile)
                elif result==3:#podong复制处理
                    print("3")
                    shutil.copy(imgPath+'/'+imgNameFile,imgPath+'/'+'podong'+'/'+imgNameFile)
                    shutil.copy(imgPath+'/'+img,imgPath+'/'+'podong'+'/'+xmlNameFile)
                elif result==4:#podong剪切处理
                    print("4")
                    shutil.move(imgPath+'/'+imgNameFile,imgPath+'/'+'podong'+'/'+imgNameFile)
                    shutil.move(imgPath+'/'+img,imgPath+'/'+'podong'+'/'+xmlNameFile)
                

            