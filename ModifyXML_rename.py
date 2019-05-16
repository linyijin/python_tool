
import os
import xml.etree.ElementTree as ET
import glob


path = r'C:\Users\Administrator\Desktop\check2'

for root_file, dirs, files in os.walk(path):
    for file in files:
        if file.find('.xml') != -1:
            xml = ET.parse(os.path.join(path, file))
            root = xml.getroot()
            for obj in root.iter('object'): 
                if obj.find('name').text == 'cusha':
                    obj.find('name').text = 'cusha_strip'
                elif obj.find('name').text == 'chousha':
                    obj.find('name').text = 'chousha_strip'
                elif obj.find('name').text == 'baijiao':
                    obj.find('name').text = 'baijiao_strip'
                elif obj.find('name').text == 'zangban':
                    obj.find('name').text = 'zangban_block'
                elif obj.find('name').text == 'shajie':
                    obj.find('name').text = 'shajie_point'
                elif obj.find('name').text == 'podong':
                    obj.find('name').text = 'podong_block'
                elif obj.find('name').text == 'zhici':
                    obj.find('name').text = 'zhici_strip'

            if root.find('object'):
                xml.write(os.path.join(path, file))
            else:
                os.remove(os.path.join(path, file))
print('well done!')
#
# if __name__ == '__main__':
#     main()
#     print('done!')