import webbrowser
import os
import time
counter = 0
while counter < 5:
    webbrowser.open_new_tab('https://blog.csdn.net/imxiangzi/article/details/50479943')
    time.sleep(1)
    counter += 1
os.system('killall  firefox')