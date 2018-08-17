#!/bin/bash
cd /var/ftp/centos71
for folder in *
do
if [ -d $folder ]; then
cat << EOF >>/root/hao8.repo
[$folder]
name=$folder
baseurl=ftp://192.168.4.1/osp8/$folder
enabled=1
gpgcheck=0
EOF
fi
done
