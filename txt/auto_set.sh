#!/bin/bash

directory=rhel7				#redhat光盘挂载文件夹如/var/www/html/$directory
ip_head=192.168.4			#Ip段
ftp_server=192.168.4.254		#ftp的ip地址
http_server=$ftp_server			#http的ip地址
dns=$ftp_server				#dns
ip_num=10				#设置ip段起始点如：$ip_head.ip_num 192.168.4.$ip_num
#设置电脑数量
com_num=4
nums=$[ip_num + $com_num]
#echo "将软件打包成tar,放进/root目录路径为/root/DBA1.tar.gz"
mkdir /opt
yum -y install dhcp-libs
echo "subnet $ip_head.0 netmask 255.255.255.0 {
  range $ip_head.$ip_num $ip_head.$[nums+2];
  option domain-name-servers $dns;
  option routers $dns;
  default-lease-time 600;
  max-lease-time 7200;
}"> /etc/dhcp/dhcpd.conf 			#增加了3个的dhcp可能分配范围

echo "重启DHCP服务中"
systemctl restart dhcpd
echo "[rhel7]
name=rhel7_yum
gpgcheck=0
enabled=1
baseurl=http://$http_server/$directory" >/opt/tmp_yum.txt

###########ftp挂载ceph光盘
echo "[mon]
name=mon
baseurl=ftp://$ftp_server/ceph/rhceph-2.0-rhel-7-x86_64/MON
gpgcheck=0
[osd]
name=osd
baseurl=ftp://$ftp_server/ceph/rhceph-2.0-rhel-7-x86_64/OSD
gpgcheck=0
[tools]
name=tools
baseurl=ftp://$ftp_server/ceph/rhceph-2.0-rhel-7-x86_64/Tools
gpgcheck=0" > /opt/tmp_yum1.txt
systemctl restart dhcpd

for i in `seq $ip_num $[nums-1]`
do
	expect << EOF
        spawn clone-vm7
        expect "number:" {send "$i\r"}
        expect eof
        
EOF
        virsh start rh7_node$i
	sleep 10
	j=$i
	while :						#分配不到ip会一直卡在这
	do
		ping -c2 -i1 ${ip_head}.$j
		if [ $? -eq 0 ];then
			ip=${ip_head}.$j
			break
		elif [ $j -ge $[nums+2] ];then
			j=$i
			continue
		fi
		let j++
	done
	expect << EOF
	spawn ssh-copy-id root@$ip
	expect "yes/no" {send "yes\r"}
	expect "password" {send "123456\r"}
	expect "#" {"exit\r"}
EOF
	ssh $ip hostnamectl set-hostname $i
	ssh $ip "nmcli connection modify eth0 ipv4.method manual ipv4.addresses ${ip_head}.$i/24 ipv4.gateway $dns ipv4.dns $dns connection.autoconnect yes"
	ssh $ip "nmcli connection up eth0" &
	echo "设置ip成功"
	ip=${ip_head}.$i
	while :						#修改Ip失败会一直卡在这
        do
                ping -c2 -i1 $ip
                [ $? -eq 0 ] && break
		
	done
	#echo "$i" > /opt/tmp_hostname.txt
	#scp /opt/tmp_hostname.txt root@$ip:/etc/hostname
	scp /opt/tmp_yum.txt root@$ip:/etc/yum.repos.d/rhel7.repo
	scp /opt/tmp_yum1.txt root@$ip:/etc/yum.repos.d/ceph.repo
	#scp /root/DBA1.tar.gz root@$ip:/root
done
sleep 3
rm -rf /opt/tmp_yum.txt
rm -rf /opt/tmp_hostname.txt
