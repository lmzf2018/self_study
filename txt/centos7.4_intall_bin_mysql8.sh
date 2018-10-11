#!/bin/bash
starttime=$(date +%s)

#rpm -e --nodeps  mariadb*
#安装mysql依赖包
yum -y install gcc gcc-c++ openssl openssl-devel libaio libaio-devel  ncurses  ncurses-devel  >> /dev/null

#mysql官网下载64位的二进制版本:mysql-8.0.12-linux-glibc2.12-x86_64.tar.xz
tar  xvfJ  /root/mysql-8.0.12-linux-glibc2.12-x86_64.tar.xz  -C  /usr/local/
mv  /usr/local/mysql-8.0.12-linux-glibc2.12-x86_64  /usr/local/mysql8


# 创建数据库文件目录和创建日志目录
mkdir  /usr/local/mysql8/{data,log}


#创建mysql组和用户
groupadd mysql
useradd -r -g mysql -s /bin/false mysql
chown  -R  mysql:mysql /usr/local/mysql8


#配置/etc/my.cnf
cat > /etc/my.cnf <<EOF
[mysqld]
port=3306
datadir=/usr/local/mysql8/data
log-error=/usr/local/mysql8/log/mysql-err.log
user=mysql
#此项是为了兼容当前的远程连接工具可以连接
default_authentication_plugin=mysql_native_password
[client]
socket=/tmp/mysql.sock
EOF

#配置环境变量
echo "export PATH=$PATH:/usr/local/mysql8/bin"  >>  /etc/profile
source /etc/profile

#初始化数据库
/usr/local/mysql8/bin/mysqld  --initialize  --user=mysql  --basedir=/usr/local/mysql8　--datadir=/usr/local/mysql8/data   >>  /dev/null


#制作启动文件
cp  /usr/local/mysql8/support-files/mysql.server  /etc/init.d/mysqld
sed  -i  's/^basedir=/basedir=\/usr\/local\/mysql8/'  /etc/init.d/mysqld
sed  -i  's/^datadir=/datadir=\/usr\/local\/mysql8\/data/'  /etc/init.d/mysqld
chmod  755 /etc/init.d/mysqld

#启动mysql服务
/etc/init.d/mysqld start


#关闭mysql服务　
#/etc/init.d/mysqld stop
echo "#####mysql8安装完成#####"


#修改mysql登录密码
b=`grep  'temporary password'   /usr/local/mysql8/log/mysql-err.log`
a=`echo ${b##*localhost:}`
echo $a
#mysql -e　可以直接在命令行执行命令
#read -p  "请输入你设定的mysql数据库密码："　$1
/usr/local/mysql8/bin/mysql -uroot -p'${a}'  -e  "ALTER USER 'root'@'localhost'  IDENTIFIED  BY '123qqq...A'"  --connect-expired-password
echo  "#####mysql8密码修改成功#####"


endtime=$(date +%s)
cost=$((endtime - starttime))
echo $cost









