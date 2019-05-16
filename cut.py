import cv2
import os

def draw_rectangle(event, x, y, flags, param):
    global srclong
    global srcwid
    global line
    strlen = len(line)
    filename = line[0:strlen-5]
    global fileSuffix
    global targetWid
    global targetLong
    srcwid = src.shape[1]
    srclong = src.shape[0]
    global count
    global ix, iy
    global x1
    global y1
    global x2
    global y2
    global date
    if event == cv2.EVENT_LBUTTONDOWN:
        ix = x * rate
        iy = y * rate
        if (srcwid - ix) < targetWid :
            y1 = srcwid
            x1 = srcwid-targetWid*2

        elif ix < targetWid:
                x1 = 0
                y1 = targetWid*2
        else :
            x1 = ix-targetWid
            y1 = ix+targetWid
        if (srclong - iy) < targetLong :
            y2 = srclong
            x2 = srclong - targetLong*2
        elif iy < targetLong :
            y2 = targetLong*2
            x2 = 0
        else:
            x2 = iy-targetLong
            y2 = iy+targetLong  #左上角(x1,x2),右下角(y1,y2)
    elif event == cv2.EVENT_LBUTTONUP:
        print("point1:=", x1, x2)
        print("point2:=", y1, y2)
        roi = tempimg[int(x2 / rate):int(y2 / rate), int(x1 / rate):int(y1 / rate)]#整个rectangle区域
        numOfCut = str(count)
        cv2.imshow("roi",roi)
        if count<10:
            numOfCut = '0' + str(count)
        while (1):
            cv2.imshow("roi", roi)
            if cv2.waitKey(20) & 0xFF == 13:#回车
                result = src[x2: y2 , x1: y1]#读取截图
                cv2.imwrite(path + "cut/"  + filename + "_" + numOfCut + "_" + version +"_" + date  + fileSuffix, result)
                cv2.rectangle(tempimg, (int(x1 / rate), int(x2 / rate)), (int(y1 / rate), int(y2 / rate)), (0, 255, 0),2)#原图画矩形
                count = count + 1
                break
            elif cv2.waitKey(20) & 0xFF == 0x3E:
                print("cancel")
                break
        cv2.destroyWindow("roi")


def mkdir(path):
    # 去除首位空格
    path = path.strip()
    # 去除尾部 \ 符号
    path = path.rstrip("\\")

    # 判断路径是否存在
    # 存在     True
    # 不存在   False
    isExists = os.path.exists(path)

    # 判断结果
    if not isExists:
        # 如果不存在则创建目录
        # 创建目录操作函数
        os.makedirs(path)


version = 'V0'
fileSuffix = ".jpg"
targetWid = 100
targetLong = 100
path = "C:/Users/lion/Desktop/0102/"
txtname = "train.txt"
date = '0927'
global rate
global count
rate = 1
f = open(path + txtname)  # 返回一个文件对象
mkdir(path + 'cut')
line = f.readline()  # 调用文件的 readline()方法
#src=cv2.imread("C:/Users/lion/Desktop/0102/20181126_F_zigouzizhi_shajie_058_r90_cr-033-shajie.jpg")
while line:
    count = 1
    strend = len(line)
    strend = strend - 1
    imagepath = path + line[0:strend]
    src = cv2.imread(imagepath)
    size = src.shape  
    tempimg = cv2.resize(src, (int(size[1] / rate), int(size[0] / rate)), cv2.INTER_LINEAR)
    cv2.imshow(line[0:strend], tempimg)
    cv2.setMouseCallback(line[0:strend], draw_rectangle)
    while(1):
        cv2.imshow(line[0:strend], tempimg)
        if cv2.waitKey(20) & 0xFF == 27:
            break
    cv2.destroyAllWindows()
    line = f.readline()
f.close()