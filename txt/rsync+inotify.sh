#!/bin/bash
#Rsync+inotify搭建实时同步系统  https://blog.51cto.com/10316297/2136440
#inotify 可以yum  -y install inotify-tools  安装
#注意rsync 同步时，源目录加“/”与不加的区别
#注意while done 后面加“&”，后台运行

#（1）编写脚本irsync.sh ,内容如下：
SRC_DIR="/root/code/"
DST_DIR="/mnt/hao"
DST_IP="111.11.11.111"
/usr/bin/inotifywait  -mrq -e modify,move,create,delete,attrib $SRC_DIR \
| while read files
    do 
      /usr/bin/rsync -az --delete $SRC_DIR  root@$DST_IP:$DST_DIR > /dev/null  2>&1
      echo "$files was rsynced"  >> /tmp/rsync.log  2>&1
    done & 
#（2）运行脚本
#[ root@lmzf ~] # chmod +x /root/irsync.sh
#[ root@lmzf ~] # /root/irsync.sh
#[ root@lmzf ~] #  pgrep  -l inotify  //确认任务在运行

#（3）将脚本加入系统自启动文件，如果rc.local没有执行权限，需要chmod +x /etc/rc.local
#[ root@lmzf ~] # echo "/root/irsync.sh " >> /etc/rc.local

#（4）测试同步效果
# 在SRC_DIR的服务器上添加文件测试
# 在DST_DIR的服务器上检查目录内容应该已经与SRC_DIR目录一致
