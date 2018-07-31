#!/bin/bash
#该脚本使用guestmount工具，可以将虚拟机的磁盘系统挂载到真实机文件系统中
#Centos7.2中安装libguestfs-tools-c可以获得guestmount工具
clear
mountpoint="/media/virimage"
#判断不存在挂载目录
[ ! -d $mountpoint ] && mkdir $mountpoint
#如果有设备挂载到该挂载点，则先umount卸载
if mount |grep -q "$mountpoint" ;then
umount $mountpoint
fi
virsh list --all
read -p "输入虚拟机名称： " name
echo "请稍后..."
#将虚拟机的磁盘文件挂载到/media/virtimage目录
guestmount -d $name -i $mountpoint
echo "---------------------------------------"
read -p "请输入要配置的ip地址: " ip
read -p "请输入要配置的子网掩码位数: " num 
#静态地址
sed -i -r "s;(BOOTPROTO=).*;\1none;" ${mountpoint}/etc/sysconfig/network-scripts/ifcfg-eth0
#开机自起
sed -i -r "s;(ONBOOT=).*;\1yes;" ${mountpoint}/etc/sysconfig/network-scripts/ifcfg-eth0
#如果ip地址不存在，就添加ip地址
grep -q "IPADDR" ${mountpoint}/etc/sysconfig/network-scripts/ifcfg-eth0 || echo "IPADDR=$ip" >> ${mountpoint}/etc/sysconfig/network-scripts/ifcfg-eth0
#如果ip地址存在
sed -i -r "s;(IPADDR=).*;\1$ip;" ${mountpoint}/etc/sysconfig/network-scripts/ifcfg-eth0
#如果子网掩码不存在，就添加子网掩码
grep -q "PREFIX" ${mountpoint}/etc/sysconfig/network-scripts/ifcfg-eth0 || echo "PREFIX=$num" >> ${mountpoint}/etc/sysconfig/network-scripts/ifcfg-eth0
#如果子网掩码存在
sed -i -r "s;(PREFIX=).*;\1$num;" ${mountpoint}/etc/sysconfig/network-scripts/ifcfg-eth0
echo "ifup eth0" >> ${mountpoint}/etc/rc.d/rc.local 
chmod +x ${mountpoint}/etc/rc.d/rc.local
umount ${mountpoint}
sleep 0.5
virsh start $name
