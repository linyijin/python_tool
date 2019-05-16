import os
import cv2
from PIL import Image
imgFilePath="C:/Users/lion/Desktop/test"
resizePath=imgFilePath+'/'+'resize'
if not os.path.exists(resizePath):
    os.mkdir(resizePath)
for root,dirs,files in os.walk(imgFilePath):
    for file in files:
        (filename,extension)=os.path.splitext(file)
        if extension==".bmp" or extension==".png":
            print(file)
            img=cv2.imread(imgFilePath+'/'+file)
            if img.any()==None:
                print("Error :the image didn't exit")
                os._exit(0)
            height,width=img.shape[:2]
            size=(int(width*0.025),int(height*0.025))
            shrik=cv2.resize(img,size,interpolation=cv2.INTER_LANCZOS4)
            shrikname=filename+".jpg"
            shrikNamePath=resizePath+'/'+shrikname
            cv2.imwrite(shrikNamePath,shrik)
print("done")
#if __name__ == '__main__':