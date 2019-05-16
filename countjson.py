import json
import os
import io


defect=['podong','cusha','shajie','baijiao','chousha','louyin','zangban','zhici','sizheyin']
def main():
    podong=0
    cusha=0
    shajie=0
    baijiao=0
    chousha=0
    louyin=0
    zangban=0
    zhici=0
    sizheyin=0
    rootPath=r'C:\Users\Administrator\Desktop\20190428\B2018112900356'
    print(rootPath)
    dirsTable=[]
    for root,dirs,files in os.walk(rootPath):
        dirsTable.append(dirs)
    for i in range(len(dirsTable[0])):#不同缺陷
        for root,dirs,files in os.walk(rootPath+'/'+dirsTable[0][i]+'/'+'CR'):
            for img in files:
                (name,fileType)=os.path.splitext(img)
                if fileType=='.json':
                    f=io.open(rootPath+'/'+dirsTable[0][i]+'/'+'CR'+'/'+img)
                    jsonFile=json.load(f)
                    family=jsonFile['shapes']
                    for text in family:
                        label=text["label"]
                        if "podong" in label:
                            podong=podong+1
                        if "cusha" in label:
                            cusha=cusha+1
                        if "shajie" in label:
                            shajie=shajie+1
                        if "baijiao" in label:
                            baijiao=baijiao+1
                        if "chousha" in label:
                            chousha=chousha+1
                        elif "gousi" in label:
                            chousha=chousha+1
                        elif "duansha" in label:
                            chousha=chousha+1
                        if "louyin" in label:
                            louyin=louyin+1
                        if "zangban" in label:
                            zangban=zangban+1
                        if "zhici" in label:
                            zhici=zhici+1
                        if "sizheyin" in label:
                            sizheyin=sizheyin+1
    sum=podong+cusha+shajie+baijiao+chousha+louyin+zangban+zhici+sizheyin
    print("podong=",podong)
    print("cusha=",cusha)
    print("shajie=",shajie)
    print("baijiao=",baijiao)
    print("chousha=",chousha)
    print("louyin=",louyin)
    print("zangban=",zangban)
    print("zhici=",zhici)
    print("sizheyin=",sizheyin)
    print("sum=",sum)
if __name__=='__main__':
    main()
    print("done")