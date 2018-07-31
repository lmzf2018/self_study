#!/bin/bash
#Author:丁丁历险(Jacob)
#该脚本使用guestmount工具，可以将虚拟机的磁盘系统挂载到真实机文件系统中
#Centos7.2中安装libguestfs-tools-c可以获得guestmount工具
#虚拟机可以启动或者不启动都不影响该脚本的使用
#将虚拟机磁盘文件挂载到文件系统后，就可以直接读取磁盘文件中的网卡配置文件中的数据
clear
mountpoint="/media/virtimage"
[ ! -d $mountpoint ] && mkdir $mountpoint
read -p "输入虚拟机名称:" name
echo "请稍后..."
#如果有设备挂载到该挂载点，则先umount卸载
if mount | grep -q  "$mountpoint" ;then
       umount $mountpoint
fi
#只读的方式，将虚拟机的磁盘文件挂载到特定的目录下，这里是/media/virtimage目录
guestmount -r -d $name -i $mountpoint
echo
echo "--------------------------------------:------"
echo -e "\033[32m$name虚拟机中网卡列表如下:\033[0m"
dev=$(ls /media/virtimage/etc/sysconfig/network-scripts/ifcfg-* | awk -F"[/-]" '{print $9}')
echo $dev
echo "--------------------------------------------"
  
echo
echo
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo -e "\033[32m网卡IP地址信息如下:\033[0m"
for i in $dev
do
       echo -n "$i:"
       grep -q "IPADDR"/media/virtimage/etc/sysconfig/network-scripts/ifcfg-$i || echo "未配置IP地址"
       awk -F= '/IPADDR/{print $2}'/media/virtimage/etc/sysconfig/network-scripts/ifcfg-$i
done
echo "+++++++++++++++++++++++++++++++++++++++++++"

