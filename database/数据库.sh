ssh免密钥登录报错：sign_and_send_pubkey: signing failed: agent refused operation
执行： eval "$(ssh-agent -s)"
      ssh-add
两条命令解决



数据库  庞丽静工作邮箱:  panglj@tedu.cn

rhel7     yum -y install mariadb-server
rhel6     yum -y install mysql

学习环境:
禁用selinux
关闭防火墙
ftp 176.19.7.250
Name:  anonymous                          //匿名登录ftp
Password： Enter



createrepo /var/ftp/mysql                 //创建yum仓库

[mysql]
name=mysql
baseurl=ftp://192.168.4.254/mysql
enable=1
gpgcheck=0

[dvd]
name=rhel7
baseurl=ftp://192.168.4.254/rhel7
enable=1
gpgcheck=0


yum -y install mysql-*                     //装包

systemctl start mysqld                     //启服务

grep -i password /var/log/mysqld.log       //查密码

mysql -uroot -p"密码"    登录

set global validate_password_policy=0;     //修改安全策略只要求长度

set global validate_password_length=6;     //修改密码长度为6

alter user user() identified by "123456";  //修改密码为123456

vim /etc/my.cnf                            //永久修改
validate_password_policy=0      
validate_password_length=6


数据库   重定义分隔符    delimiter #         //命令结束符号;换成#
1.购买服务器(硬件主机 云主机)
2.安装操作系统: Unix Linux Windows
3.装包
  软件包的来源 :官网下载  操作系统光盘自带
  软件包封包类型:RPM 源码
  源码:可以自定义配置和安装  必须解决依赖关系
  RPM:软件是封装好的 不可以自定义安装 安装卸载简单
  开源软件还是商业软件:
  开源软件:不等于免费
  商业软件:以赚钱为目的
  提供数据库服务的软件:Mysql Oracle SQLserver DB2 (RDBMS关系型数据库软件)
                      Redis Mongodb Memcached    (NoSQL非关系型软件)
  Mysql的特点:
     开源且跨平台:unix linux windows
     支持主流的编程语言:php java python ruby perl
     可移植性好:系统只要有c的运行环境   gcc  gcc-c++
  数据库服务通常和网站服务一起使用:LAMP  LNMP
      购物网站  游戏网站  视频网站  论坛网站  金融网站 
  数据库服务用来存储什么样的数据:

第一天上午:

安装MySQL

mysql-community-server-5.7.17-1.el7.x86_64rpm
mysql-community-client-5.7.17-1.el7.x86_64rpm

1.装包:
systemctl stop mariadb            //停止mariadb
rpm -e --nodeps mariadb-server    //卸载mariadb-server 忽略依赖关系
rpm -e --nodeps mariadb-libs      //卸载mariadb-libs 忽略依赖关系
rm -rf /var/lib/mysql             //删除配置文件
rm -rf /etc/my.cnf                //删除配置文件
yum -y install perl-JSON
rpm -Uvh mysql-community-*.rpm

2.修改配置文件
/etc/my.cnf               	  //修改mysql配置文件

3.启动服务  
systemctl start mysqld       	  //启动mysql
systemctl enable mysqld     	  //设置开机自启

查看服务信息
netstat -utnlp | grep mysqld  	  //端口号 3306        查看端口号 
pc -C mysqld                  	  //进程 mysqld        查看进程    

把数据存储到数据库服务器上的过程
1.链接数据库服务器  mysql -h(ip) -u(用户名) -p(密码)
2.创建库        
3.建表
4.插入数据
5.断开连接

###############################################################################
第一天下午:

数据库的命名规则:可以使用数字/字母/下划线,但不能为纯数字
                区分大小写,具有唯一性
                不可以使用指令关键字,特殊字符

SQL命令:
show databases;            	//显示已有的库
create database (库名);    	//创建库
drop database (库名);       	//删除库
use (库名);                 	//切换库
select database();          	//显示当前所在的库
show tables;                	//显示已有的表

使用SQL(结构化查询语言)命令的使用规则和分类:
  1.每条命令必须以;(分号)结束或分隔
  2.命令不区分大小写(密码和变量除外)
  3.不支持tab自动补全数据库操作:
  4.\c可以废弃当前的命令

常用SQL的操作指令
  1.DDL数据定义语言   (create  alter  drop)
  2.DML数据操作语言   (insert  update  delete)
  3.DCL数据控制语言   (grant  remoke)
  4.DTL数据事物语言   (commit  rollback  savepoint)

数据表:

表必须在库里创建

create database md1;         //创建md1库
create table md1.student(    //在md1库中创建student表
name char(15),               //第一个字段名为name,最多15个字符
sex char(10),                //第二个字段名为sex,最多10个字符
age int,                     //第三个字段名为age,只能为整数
tel char(11)                 //第四个字段名为tel,最多11个字符
);

desc md1.student              		//查看student表的结构
+-------+----------+------+-----+---------+-------+
| Field | Type     | Null | Key | Default | Extra |
+-------+----------+------+-----+---------+-------+
| name  | char(15) | YES  |     | NULL    |       |
| sex   | char(10) | YES  |     | NULL    |       |
| age   | int(11)  | YES  |     | NULL    |       |
| tel   | char(11) | YES  |     | NULL    |       |
+-------+----------+------+-----+---------+-------+

insert into student values("lujiawen","boy",26,18258846257);	//插入表记录
select * from student;	           //查看student表的内容
+----------+------+------+-------------+
| name     | sex  | age  | tel         |
+----------+------+------+-------------+
| lujiawen | boy  |   26 | 18258846257 |
+----------+------+------+-------------+

drop table student      	//删除表

insert into student(name) values("lujiawen");       //只给某些字段赋值
select * from student;     		//查看表记录
+----------+------+------+-------------+
| name     | sex  | age  | tel         |
+----------+------+------+-------------+
| lujiawen | boy  |   26 | 18258846275 |
| lujiawen | NULL | NULL | NULL        |
+----------+------+------+-------------+

update student set name="lu";        	//批量修改表记录
+------+------+------+-------------+
| name | sex  | age  | tel         |
+------+------+------+-------------+
| lu   | boy  |   26 | 18258846275 |
| lu   | NULL | NULL | NULL        |
+------+------+------+-------------+

delete from md1.student;             	//删除表记录

show create table 学员信息表(表名);      //查看建表时使用的命令

中文字符集  utf8  gb2312  big5

create table 学员信息表(姓名 char(10),年龄 int) default charset=utf8;
                                                 //修改字符集,可以输入中文
+--------+----------+------+-----+---------+-------+
| Field  | Type     | Null | Key | Default | Extra |
+--------+----------+------+-----+---------+-------+
| 姓名   | char(10) | YES  |     | NULL    |       |
| 年龄   | int(11)  | YES  |     | NULL    |       |
+--------+----------+------+-----+---------+-------+

echo "detault charset=utf8" >> /etc/my_cnf       //永久修改中文字符集

MySQL数据类型:
  数值类型:
    整数类型:
        tinyint  1字节 -128~127(有符号)  0~255(无符号)  微小整数
        smallint 2字节 -32768~32767(有符号)  0~65535(无符号)  小整数
        mediumint 3字节 -2^23~2^23-1(有符号)  0~2^24-1(无符号) 中整数
        int 4字节 -2^31~2^31-1(有符号)  0~2^32-1(无符号)  大整数
        binint 8字节 -2^63~2^63-1(有符号)  0~2^64-1(无符号)  极大整数
    浮点类型:
        float 4字节      单精度浮点数
        double 8字节     双精度浮点数
    字符类型:
        char:固定长度,最大255
        varchar:可变长度,最大不超过65532
          大文本类型:
            text
            blob

整数:
create table t1(level tinyint unsigned); //创建t1表,设置level结构,无符号范围
浮点:
create table t2(pay float(7,2)); //创建t2表,设置pay字段,总位数7,保留2位小数
字符:
create table t3(name char(5));  //创建t3表,设置name字段,5个字符不足的在前面补空格
create table t4(name varchar(5));  //创建t4表,设置name字段,最多5个字符

create table t5(gamename char(15),level int unsigned,pay float(7,2));
      //创建t5表,设置gamename字段15个字符,不足的在前面补全空格,level字段非负数的整数,pay字段浮点数总位数7,保留2位小数

枚举类型:让字段的值在规定的范围内选择
  enum:单选
  set:多选

create table t6(name char(15),sex enum("boy","girl","no"),likes set("game","film","sleeps","eat"));
      //创建t6表,设置name字段15个字符,不足的在前面补全空格,sex字段单选,"boy,girl,no"中三选一,likes字段多选,"ganme,film,sleeps,eat"任选
insert into t6 values("hebe","girl","game,sleeps");
+-------+-----------------------------------+------+-----+---------+-------+
| Field | Type                              | Null | Key | Default | Extra |
+-------+-----------------------------------+------+-----+---------+-------+
| name  | char(15)                          | YES  |     | NULL    |       |
| sex   | enum('boy','girl','no')           | YES  |     | NULL    |       |
| likes | set('game','film','sleeps','eat') | YES  |     | NULL    |       |
+-------+-----------------------------------+------+-----+---------+-------+


###############################################################################

第二天上午:

日期时间类型:    
年        year      YYYY           2018         范围1901~2155
  //当只用2位数给year赋值时,01~69视为2001~2069,70~99视为1970~1999,不能使用00和100
日期      date      YYYYMMDD       20180726     范围0001-01-01~9999-12-31
时间      time      HHMMSS         125959
日期时间  datetime  YYYYMMDDHHMMSS  20181231235959
         timestamp                 20180711093758
use db2
create table t1(
name char(15),
birthday date,
work time,
s_year year,
meetting datetime
);
+----------+----------+------+-----+---------+-------+
| Field    | Type     | Null | Key | Default | Extra |
+----------+----------+------+-----+---------+-------+
| name     | char(15) | YES  |     | NULL    |       |
| birthday | date     | YES  |     | NULL    |       |
| work     | time     | YES  |     | NULL    |       |
| s_year   | year(4)  | YES  |     | NULL    |       |
| meetting | datetime | YES  |     | NULL    |       |
+----------+----------+------+-----+---------+-------+

insert into t1 values("yy",20180726,080000,1993,20180715103000);
+------+------------+----------+--------+---------------------+
| name | birthday   | work     | s_year | meetting            |
+------+------------+----------+--------+---------------------+
| yy   | 2018-07-26 | 08:00:00 |   1993 | 2018-07-15 10:30:00 |
+------+------------+----------+--------+---------------------+


datetime与timestamp的区别
datetime占用8个字节    	 //当未给datetime赋值时,默认赋值为null     
timestamp占用4个字节   	 //当未给timestamp赋值时,默认以当前时间赋值
	
select now();            //获取系统时间		//2018-07-15 10:50:50
select year(now());      //获取系统年份		//2018
select year(20180715);   //获取指定时间年份 	//2018
select month(now());     //获取系统月份      	//7
select month(20180715);  //获取指定时间月份  	//7
select day(now());       //获取系统几号		//15
select day(20180715);    //获取指定时间几号	//15
select date(now());      //获取系统日期		//2018-07-15
select time(now());      //获取系统时间   	//10:50:50


数值类型的宽度是显示宽度,不能限制字段赋值的大小,字段值的大小由类型决定
                                //int默认宽度为11,数值位数不到11时在前面补全空格
create table t1( 		//创建t1表
id int(4) unsigned zerofill,	//设置id字段,int类型,显示宽度4位,不足时以0补全
age int(2) unsigned zerofill    //设置age字段,int类型,显示宽度2位,不足时以0补全
);  
+-------+--------------------------+------+-----+---------+-------+
| Field | Type                     | Null | Key | Default | Extra |
+-------+--------------------------+------+-----+---------+-------+
| id    | int(4) unsigned zerofill | YES  |     | NULL    |       |
| age   | int(2) unsigned zerofill | YES  |     | NULL    |       |
+-------+--------------------------+------+-----+---------+-------+

insert into t1 values (5,5);    //设置id字段数值为5,设置age字段数值为5
select * from t1;               //查看t1表记录
显示结果:   id:0005    age:05
+------+------+
| id   | age  |
+------+------+
| 0005 |   05 |
+------+------+

约束条件作用:如何给字段赋值

约束条件:       Null        Key        Default       Extra
         是否允许赋null值   键值        默认值       额外设置

create table t1(		              
name char(15) not null default "shabi",       
class char(7) default "nsd1804", 	      
age tinyint(2) not null default 18,
sex enum("boy","gril") not null default "boy"
);
+-------+--------------------+------+-----+---------+-------+
| Field | Type               | Null | Key | Default | Extra |
+-------+--------------------+------+-----+---------+-------+
| name  | char(15)           | NO   |     | shabi   |       |
| class | char(7)            | YES  |     | nsd1804 |       |
| age   | tinyint(2)         | NO   |     | 18      |       |
| sex   | enum('boy','gril') | NO   |     | boy     |       |
+-------+--------------------+------+-----+---------+-------+

not null                    //该字段不可为空
default xxx		    //该字段默认值为xxx

###############################################################################
第二天下午:

create table v1(name varchar(15),class char(7),age tinyint(2));
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| name  | varchar(15) | YES  |     | NULL    |       |
| class | char(7)     | YES  |     | NULL    |       |
| age   | tinyint(2)  | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+

修改表结构:对已经创建的表结构做修改

添加表字段:
alter table v1 add email varchar(50) default "student@tedu.cn",
add qq char(11);  //在v1中添加email字段,可变宽度50,默认student@tedu.cn和qq字段
+-------+-------------+------+-----+-----------------+-------+
| Field | Type        | Null | Key | Default         | Extra |
+-------+-------------+------+-----+-----------------+-------+
| name  | varchar(15) | YES  |     | NULL            |       |
| class | char(7)     | YES  |     | NULL            |       |
| age   | tinyint(2)  | YES  |     | NULL            |       |
| email | varchar(50) | YES  |     | student@tedu.cn |       |
| qq    | char(11)    | YES  |     | NULL            |       |
+-------+-------------+------+-----+-----------------+-------+

alter table v1 add stu_num char(9) first,
add likes set("eat","sleep","game") after age;
                  //在v1表中第一行添加stu_num字段,age之后添加likes字段
+---------+---------------------------+------+-----+-----------------+-------+
| Field   | Type                      | Null | Key | Default         | Extra |
+---------+---------------------------+------+-----+-----------------+-------+
| stu_num | char(9)                   | YES  |     | NULL            |       |
| name    | varchar(15)               | YES  |     | NULL            |       |
| class   | char(7)                   | YES  |     | NULL            |       |
| age     | tinyint(2)                | YES  |     | NULL            |       |
| likes   | set('eat','sleep','game') | YES  |     | NULL            |       |
| email   | varchar(50)               | YES  |     | student@tedu.cn |       |
| qq      | char(11)                  | YES  |     | NULL            |       |
+---------+---------------------------+------+-----+-----------------+-------+

删除字段:
alter table v1 drop email,drop qq;     //删除v1表中的email字段和qq字段
+---------+---------------------------+------+-----+---------+-------+
| Field   | Type                      | Null | Key | Default | Extra |
+---------+---------------------------+------+-----+---------+-------+
| stu_num | char(9)                   | YES  |     | NULL    |       |
| name    | varchar(15)               | YES  |     | NULL    |       |
| class   | char(7)                   | YES  |     | NULL    |       |
| age     | tinyint(2)                | YES  |     | NULL    |       |
| likes   | set('eat','sleep','game') | YES  |     | NULL    |       |
+---------+---------------------------+------+-----+---------+-------+

修改字段类型:
alter table v1 modify name varchar(15);//修改v1表中name字段类型为varchar(15)
+---------+---------------------------+------+-----+---------+-------+
| Field   | Type                      | Null | Key | Default | Extra |
+---------+---------------------------+------+-----+---------+-------+
| stu_num | char(9)                   | YES  |     | NULL    |       |
| name    | varchar(15)               | YES  |     | NULL    |       |
| class   | char(7)                   | YES  |     | NULL    |       |
| age     | tinyint(2)                | YES  |     | NULL    |       |
| likes   | set('eat','sleep','game') | YES  |     | NULL    |       |
+---------+---------------------------+------+-----+---------+-------+

alter table v1 modify age int(2) not null default 18;
修改字段类型时,若新的类型与字段已经存储的数据冲突,不允许修改,不修改的部分要原样抄下来,否则就是还原
+---------+---------------------------+------+-----+---------+-------+
| Field   | Type                      | Null | Key | Default | Extra |
+---------+---------------------------+------+-----+---------+-------+
| stu_num | char(9)                   | YES  |     | NULL    |       |
| name    | varchar(15)               | YES  |     | NULL    |       |
| class   | char(7)                   | YES  |     | NULL    |       |
| age     | int(2)                    | NO   |     | 18      |       |
| likes   | set('eat','sleep','game') | YES  |     | NULL    |       |
+---------+---------------------------+------+-----+---------+-------+

修改字段位置:
alter table v1 modify age int(2) not null default 18 after likes;
                                       //把age字段移到likes之后,其他不变
+---------+---------------------------+------+-----+---------+-------+
| Field   | Type                      | Null | Key | Default | Extra |
+---------+---------------------------+------+-----+---------+-------+
| stu_num | char(9)                   | YES  |     | NULL    |       |
| name    | varchar(15)               | YES  |     | NULL    |       |
| class   | char(7)                   | YES  |     | NULL    |       |
| likes   | set('eat','sleep','game') | YES  |     | NULL    |       |
| age     | int(2)                    | NO   |     | 18      |       |
+---------+---------------------------+------+-----+---------+-------+

修改字段名:
alter table v1 change age xx char(11);  //把v1表中age字段改为xx字段
+---------+---------------------------+------+-----+---------+-------+
| Field   | Type                      | Null | Key | Default | Extra |
+---------+---------------------------+------+-----+---------+-------+
| stu_num | char(9)                   | YES  |     | NULL    |       |
| name    | varchar(15)               | YES  |     | NULL    |       |
| class   | char(7)                   | YES  |     | NULL    |       |
| likes   | set('eat','sleep','game') | YES  |     | NULL    |       |
| xx      | char(11)                  | YES  |     | NULL    |       |
+---------+---------------------------+------+-----+---------+-------+

修改表名:
alter table v1 rename v2;              //把v1表改为v2,内容不变
+-----------------+
| Tables_in_md1   |
+-----------------+
| v2              |
+-----------------+


MYSQL键值 约束如何给字段赋值
普通索引 index
算法:Btree(二叉树算法)  B+tree
介绍:给字段值排序的树型结构,类似与书的目录
优点:加快查找数据的速度
缺点:减慢写入数据的速度,占用物理存储空间
用法:
  查看:
    show index from v1\G;           //查看v1表的索引,\G换行显示
  创建:
    create index name1 on v1(name);   //给v1表中name字段创建名为name1的索引
    desc v1;                          //已经创建索引的会在key行下面显示MUL
+---------+---------------------------+------+-----+---------+-------+
| Field   | Type                      | Null | Key | Default | Extra |
+---------+---------------------------+------+-----+---------+-------+
| stu_num | char(9)                   | YES  |     | NULL    |       |
| name    | varchar(15)               | YES  | MUL | NULL    |       |
| class   | char(7)                   | YES  |     | NULL    |       |
| likes   | set('eat','sleep','game') | YES  |     | NULL    |       |
| xx      | char(11)                  | YES  |     | NULL    |       |
+---------+---------------------------+------+-----+---------+-------+

  删除:
    drop index name1 on v1;           //删除v1表中的名为name1的索引
  建表时创建索引:
    create table v1(
    name varchar(15),
    class char(7),
    age tinyint(2),
    index(name),                      //创建name字段的索引
    index(class)                      //创建class字段的索引
    );
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| name  | varchar(15) | YES  | MUL | NULL    |       |
| class | char(7)     | YES  | MUL | NULL    |       |
| age   | tinyint(2)  | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+

主键:primary key 限制如何给字段赋值
primary key 使用规则:
    一个表中只能有一个primary key字段,不能赋null值,不能重复
    
    建表时创建主键字段:
      create table v1(             |    create table v1(      
      name char(15) primary key,   |    name char(15),
      class char(7),               |    class char(7),
      age tinyint(2)               |    age tinyint(2),
      );                           |    primary key(name)
                                   |    );
+-------+------------+------+-----+---------+-------+
| Field | Type       | Null | Key | Default | Extra |
+-------+------------+------+-----+---------+-------+
| name  | char(15)   | NO   | PRI | NULL    |       |
| class | char(7)    | YES  |     | NULL    |       |
| age   | tinyint(2) | YES  |     | NULL    |       |
+-------+------------+------+-----+---------+-------+

    在已有表里设置主键:
      delete from v1;                          //有重复时删除
      alter table v1 add primary key(name);    //把name字段设为主键
 
    已创建主键的在key下用PRI表示
     
    删除主键:
      alter table v1 drop primary key;         //删除v1表中的主键

    创建复合主键:表中多个字段一起做主键,赋值时主键字段的值不允许完全相同
     create table v1(
      name char(15),
      class char(7),
      pay enum("yes","no"),
      primary key(name,class)                  //把name和class字段设为复合主键
      );

    在已有表里创建复合主键:
      delete from v1;                          //有重复时删除
      alter table v1 add primary key(name,age);//把name和age字段设为复合主键

###############################################################################
第三天上午:

auto_increment只能添加在主键字段上,让字段的值自动增长
向表中插入记录时,不赋值,用当前字段最大的值+1的结果当做新记录的值

create table 学生资料(
序号 int(2) primary key auto_increment,    //设置序号字段为主键自增长
姓名 char(15) not null,
年龄 tinyint(2) not null,
学费 float(7,2) default 26800
) default charset=utf8;
+--------+------------+------+-----+----------+----------------+
| Field  | Type       | Null | Key | Default  | Extra          |
+--------+------------+------+-----+----------+----------------+
| 序号   | int(2)     | NO   | PRI | NULL     | auto_increment |
| 姓名   | char(15)   | NO   |     | NULL     |                |
| 年龄   | tinyint(2) | NO   |     | NULL     |                |
| 学费   | float(7,2) | YES  |     | 25800.00 |                |
+--------+------------+------+-----+----------+----------------+

insert into 学生资料(姓名,年龄,学费) values("鲁佳文",26,25800);
+--------+-----------+--------+----------+
| 序号   | 姓名      | 年龄    | 学费     |
+--------+-----------+--------+----------+
|      1 | 鲁佳文    |     26 | 25800.00 |
+--------+-----------+--------+----------+
insert into 学生资料(姓名,年龄,学费) values("鲁佳文1",26,25800);
insert into 学生资料(姓名,年龄,学费) values("鲁佳文2",26,25800);
+--------+------------+--------+----------+
| 序号   | 姓名       | 年龄    | 学费     |
+--------+------------+--------+----------+
|      1 | 鲁佳文     |     26 | 25800.00 |
|      2 | 鲁佳文1    |     26 | 25800.00 |
|      3 | 鲁佳文2    |     26 | 25800.00 |
+--------+------------+--------+----------+

外键:foreign key
介绍:让当前表字段的值在另一个表的字段值的范围中选择
使用规则:表的存储引擎必须时innodb,字段类型要一致,被参照的字段必须要是索引类型的一种

create table 员工信息表(
工号 int(3) primary key auto_increment,
姓名 char(15),
部门 char(20)) 
engine=innodb default charset=utf8;

+--------+----------+------+-----+---------+----------------+
| Field  | Type     | Null | Key | Default | Extra          |
+--------+----------+------+-----+---------+----------------+
| 工号   | int(3)   | NO   | PRI | NULL    | auto_increment |
| 姓名   | char(15) | YES  |     | NULL    |                |
| 部门   | char(20) | YES  |     | NULL    |                |
+--------+----------+------+-----+---------+----------------+

insert into 员工信息表(姓名,部门) values("鲁佳文","财务部");
insert into 员工信息表(姓名,部门) values("鲁佳文1","财务部");
insert into 员工信息表(姓名,部门) values("鲁佳文2","财务部");
+--------+------------+-----------+
| 工号   | 姓名       | 部门       |
+--------+------------+-----------+
|      1 | 鲁佳文     | 财务部     |
|      2 | 鲁佳文1    | 财务部     |
|      3 | 鲁佳文2    | 财务部     |
+--------+------------+-----------+

创建外键:
create table 员工工资表(
工号 int(3),
工资 float(7,2) unsigned,
foreign key(工号) references 员工信息表(工号)
on delete cascade on update cascade
) engine=innodb default charset=utf8;
                     //on delete cascade 同步删除
                     //on update cascade 同步更新
                     //员工工资表中工号做外键,参照员工信息表中的工号
+--------+---------------------+------+-----+---------+-------+
| Field  | Type                | Null | Key | Default | Extra |
+--------+---------------------+------+-----+---------+-------+
| 工号   | int(3)              | YES  | MUL | NULL    |       |
| 工资   | float(7,2) unsigned | YES  |     | NULL    |       |
+--------+---------------------+------+-----+---------+-------+

insert into 员工工资表 values (1,50000);
insert into 员工工资表 values (2,30000);
insert into 员工工资表 values (3,40000);
+--------+----------+
| 工号   | 工资     |
+--------+----------+
|      1 | 50000.00 |
|      2 | 30000.00 |
|      3 | 40000.00 |
+--------+----------+
insert into 员工工资表 values (4,60000);      //报错,因为员工信息表工号字段没有4

delete from 员工信息表 where 工号=2;          //删除员工信息表工号为2的行
员工信息表:
+--------+------------+-----------+
| 工号   | 姓名       | 部门      |
+--------+------------+-----------+
|      1 | 鲁佳文     | 财务部    |
|      3 | 鲁佳文2    | 财务部    |
+--------+------------+-----------+
员工工资表:
+--------+----------+
| 工号   | 工资     |
+--------+----------+
|      1 | 50000.00 |
|      3 | 40000.00 |
+--------+----------+            //因为外键设置了同步删除,所以员工工资表的2也没了

alter table 员工工资表 add primary key(工号);
                                 //把员工工资表的工号做成主键,避免重复跟空值

删除外键:
show create table 员工工资表;     //通过查询建表记录找到外键名
alter table 员工工资表 drop foreign key 员工工资表_ibfk_1;
                                 //删除外键

###############################################################################
第三天下午:

数据导入:把系统文件的内容存储到数据库服务器的表里  有格式规律
数据导出:把服务器表里的记录存储到系统文件里
文件路径相同:默认为 /var/lib/mysql-files
show variables like "secure_file_priv";      //查看文件默认存储路径
+------------------+-----------------------+
| Variable_name    | Value                 |
+------------------+-----------------------+
| secure_file_priv | /var/lib/mysql-files/ |
+------------------+-----------------------+

自定义数据导入导出的文件路径:
mkdir /mydata                                //创建一个目录
chown mysql /mydata                          //修改目录所有者为mysql
vim /etc/my.cnf                              //打开配置文件
[mysqld]
secure_file_priv="/mydata"                   //修改文件默认保存位置

systemctl restart mysqld                     //重启mysql服务
show variables like "secure_file_priv";
+------------------+-------+
| Variable_name    | Value |
+------------------+-------+
| secure_file_priv | /my/  |
+------------------+-------+

在数据库中使用系统命令:在命令前加上 system 
mysql> system cp /etc/passwd /my

导入数据的步骤:
1.把系统文件拷贝到指定目录
  cp /etc/passwd /my
2.创建储存文件的内容的表
  create table user(
    name char(50),
    password char(1),
    uid int(2),
    gid int(2),
    comment varchar(150),
    homedir char(150),
    shell char(50),
    index(name)
    );
+----------+--------------+------+-----+---------+-------+
| Field    | Type         | Null | Key | Default | Extra |
+----------+--------------+------+-----+---------+-------+
| name     | char(50)     | YES  | MUL | NULL    |       |
| password | char(1)      | YES  |     | NULL    |       |
| uid      | int(2)       | YES  |     | NULL    |       |
| gid      | int(2)       | YES  |     | NULL    |       |
| comment  | varchar(150) | YES  |     | NULL    |       |
| homedir  | char(150)    | YES  |     | NULL    |       |
| shell    | char(50)     | YES  |     | NULL    |       |
+----------+--------------+------+-----+---------+-------+

导入数据:
load data infile "/my/passwd" into table 第三天.user fields terminated by ":" lines terminated by "\n";
                               //将passwd中数据导入user表
fields terminated by ":"       //修改每列分隔符为:
lines terminated by "\n"       //修改每行分隔符为\n(换行符)

alter table user add id int(2) primary key auto_increment first;
                               //在user表中第一行添加id字段,自动增加
+----------+--------------+------+-----+---------+----------------+
| Field    | Type         | Null | Key | Default | Extra          |
+----------+--------------+------+-----+---------+----------------+
| id       | int(2)       | NO   | PRI | NULL    | auto_increment |
| name     | char(50)     | YES  | MUL | NULL    |                |
| password | char(1)      | YES  |     | NULL    |                |
| uid      | int(2)       | YES  |     | NULL    |                |
| gid      | int(2)       | YES  |     | NULL    |                |
| comment  | varchar(150) | YES  |     | NULL    |                |
| homedir  | char(150)    | YES  |     | NULL    |                |
| shell    | char(50)     | YES  |     | NULL    |                |
+----------+--------------+------+-----+---------+----------------+

select * from user where id=1;   //显示指定行
+----+------+----------+------+------+---------+---------+-----------+
| id | name | password | uid  | gid  | comment | homedir | shell     |
+----+------+----------+------+------+---------+---------+-----------+
|  1 | root | x        |    0 |    0 | root    | /root   | /bin/bash |
+----+------+----------+------+------+---------+---------+-----------+

数据导出:
select * from user into outfile "/my/user1.txt" fields terminated by "#" lines terminated by "!!!";
                             //把数据导出到/my/user.txt
                             //每列分隔符为#
                             //每行分隔符为!!!

管理表记录:

添加表记录:
insert into user values
(43,"ljw","x",1001,1001,"","/home/ljw","/bin/bash"),
(44,"ljw1","x",1002,1002,"","/home/ljw1","/bin/bash");
                             //一次添加两个表记录

查询表记录:
select 字段名 from 表 where 条件;
select name,uid,shell from user where id=1;
                             //查找id=1的name,uid,shell列的信息
+------+------+-----------+
| name | uid  | shell     |
+------+------+-----------+
| root |    0 | /bin/bash |
+------+------+-----------+
                            
更新记录字段的值:
update 表 set 字段名=值,字段名1=值 where 条件;
update user set password="A",gid=1000;
                             //把每一行的password的值改成A,gid的值改成1000
update user set password="B" where id=1;
                             //把id为1一行中的password的值改成B

删除表记录:
delete from user where password=A;
                             //把user表中password值为A的列删除

数值比较:>   >=   <   <=   =   !=
where 字段名 符号  数值
select * from user where id<=10;
                              //查找user表中,id小于等于10的行

select name,uid,gid from where uid=gid;
                              //查找user表中,uid等于gid的行中name,uid,gid的值

字符比较:=(相等)   !=(不等)   is null(匹配空)    is not null(匹配非空)
select name from user where name="apache";
                              //查找user表中,name等于apache的行中name的值
                    
insert into user(id,name) values(43,""),(44,"null"),(45,null);
select id,name from user where id>42;
+----+------+
| id | name |
+----+------+
| 43 |      |
| 44 | null |
| 45 | NULL |
+----+------+

select * from user where name="";       //查找user表中""
select * from user where name="null";  //查找user表中值为null
select * from user where name is null;     //查找user表中的空值 

多条件查找: or 或者     and 和     ! 取反     () 提高优先级
select * from user where name="root" and uid=0 and gid=0;
                           //查找user表中,name等于root,uid和gid都等于0的行
+------+----------+------+------+---------+---------+-----------+----+
| name | password | uid  | gid  | comment | homedir | shell     | id |
+------+----------+------+------+---------+---------+-----------+----+
| root | x        |    0 |    0 | root    | /root   | /bin/bash |  1 |
+------+----------+------+------+---------+---------+-----------+----+

select name,uid from user where name="root" or uid=1 or gid=2;
                          //查找user表中,name等于root,或uid等于1,或gid等于2的行
+--------+------+
| name   | uid  |
+--------+------+
| root   |    0 |
| bin    |    1 |
| daemon |    2 |
+--------+------+

select name,uid from user where name="root" or name="bin" and uid=1;
                        //查找user表中name等于root,或者name等于bin且uid等于1的行
+------+------+
| name | uid  |
+------+------+
| bin  |    1 |
| root |    0 |
+------+------+

select name,uid from user where (name="root" or name="bin") and uid=1;
                        //查找user表中name等于root或者bin且uid等于1的行
+------+------+
| name | uid  |
+------+------+
| bin  |    1 |
+------+------+

范围内匹配:
select name from user where name in ("root","sync","lucy","bob");  
              //查找user表中name等于"root","sync","lucy","bob"之中的值的行
+------+
| name |
+------+
| root |
| sync |
+------+

select name,uid from user where shell not in ("/bin/bash","/sbin/nologin"); 
                   //查找user表中shell的值不是/bin/bash或者/sbin/nologin的行
+----------+------+
| name     | uid  |
+----------+------+
| sync     |    5 |
| shutdown |    6 |
| halt     |    7 |
| mysql    |   27 |
+----------+------+

select name,uid from user where uid between 10 and 20;
                              //查找user表中uid值在10到20之间的行
+----------+------+
| name     | uid  |
+----------+------+
| operator |   11 |
| games    |   12 |
| ftp      |   14 |
+----------+------+

distinct (只使用于查询)
select distinct shell from user where uid<500;   
                     //查找user表中uid小于500的,shell值重复只显示第一行
+----------------+
| shell          |
+----------------+
| /bin/bash      |
| /sbin/nologin  |
| /bin/sync      |
| /sbin/shutdown |
| /sbin/halt     |
| /bin/false     |
+----------------+

###############################################################################
第四天上午:

mysql
管理表记录:    select update insert delete

基本匹配条件:  >        \   >=      \   <     \   <=     \    =    \   !=
              in       \  not in   \  between  ... and  ...
              is null  \  is not null               
              or       \   and     \   ! not  \   ()

高级匹配条件:  
模糊查询: _匹配一个字符     %匹配0个或多个字符  %x代表以x结尾  x%代表以x开头
          select name from usertab where 字段 like  "表达式";
          
          select name from usertab where name like "r%" or name like "%c" or name like "%a%";
                   //查找usertab表中,name字段r开头或者以c结尾或者包含a的值
+---------------------+
| name                |
+---------------------+
| root                |
| daemon              |
| adm                 |
| sync                |
| halt                |
| mail                |
| operator            |
| games               |
| libstoragemgmt      |
| rpc                 |
| saslauth            |
| abrt                |
| rtkit               |
| radvd               |
| rpcuser             |
| gnome-initial-setup |
| avahi               |
| apache              |
+---------------------+

          select name from usertab where name like "____";
                   //查找usertab表中,name字段4个字符的行的值 (几个_代表几个字符)
+------+
| name |
+------+
| root |
| sync |
| halt |
| mail |
| dbus |
| abrt |
| qemu |
| sshd |
+------+

正则匹配:
where 字段名 regexp "正则表达式";
select name from usertab where name regexp "^a.*t$"; 
                    //查找usertab表中name字段a开头t结尾中间任意字符的行
+------+
| name |
+------+
| abrt |
+------+

select name from usertab where name regexp "[0-9]";
                      //查找usertab表中name字段有数字的行
+-------+
| name  |
+-------+
| 1aaaa |
| aa2aa |
| aaaa3 |
+-------+

select name,uid from usertab where uid regexp "....";
                         //查找usertab表中uid字段至少4个字符
+-----------+-------+
| name      | uid   |
+-----------+-------+
| nfsnobody | 65535 |
| student   |  1000 |
| ljw       |  1002 |
+-----------+-------+

select name,uid,gid , uid + gid 结果 from usertab where uid>1000;
             //把usertab表中uid字段大于1000的行uid值+gid值的答案显示在"结果"标题下
+-----------+-------+-------+--------+
| name      | uid   | gid   | 结果   |
+-----------+-------+-------+--------+
| nfsnobody | 65534 | 65534 | 131068 |
| ljw       |  1001 |  1001 |   2002 |
+-----------+-------+-------+--------+

update usertab set uid=uid+1 where uid>1000;
                     //把usertab表中uid大于1000的行中uid的值改为uid+1的值
+-----------+-------+
| name      | uid   |
+-----------+-------+
| nfsnobody | 65535 |
| ljw       |  1002 |
+-----------+-------+

alter table usertab add age tinyint(2) unsigned default 18 after name;
select name,age,2018-age s_Year from user where name="root";
                      //usertab表中root用户s_year为2018-age
+------+------+--------+
| name | age  | s_Year |
+------+------+--------+
| root |   18 |   2000 |
+------+------+--------+

select name,uid,gid,(uid+gid)/2 pjz from user where uid>1000;
                 //在pjz字段下显示uid大于1000的行uid值+gid值的和除以2的结果
+-----------+-------+-------+------------+
| name      | uid   | gid   | pjz        |
+-----------+-------+-------+------------+
| nfsnobody | 65535 | 65534 | 65534.5000 |
| ljw       |  1002 |  1001 |  1001.5000 |
+-----------+-------+-------+------------+

聚集函数:mysql服务自带的对数据做统计的命令
avg(字段名)                           //统计字段平均值
sum(字段名)                           //统计字段的和
min(字段名)                           //统计字段最小值
max(字段名)                           //统计字段最大值
count(字段名)                         //统计字段值个数

select sum(uid) from usertab where uid>1000;
                                      //统计uid大于1000的行uid相加的和
+----------+
| sum(uid) |
+----------+
|    66537 |
+----------+

select count(uid) from usertab where shell="/bin/bash";
                                      //统计shell为/bin/bash的行的个数
+------------+
| count(uid) |
+------------+
|          2 |
+------------+

select avg(uid) from usertab where uid>1000;
                                      //统计uid大于1000的行uid的平均值
+------------+
| avg(uid)   |
+------------+
| 33268.5000 |
+------------+

select min(uid) from usertab where uid>1000;
                                      //统计uid大于1000的行中uid最小的值
+----------+
| min(uid) |
+----------+
|     1002 |
+----------+

select max(uid) from usertab where uid>1000;
                                       //统计uid大于1000的行中uid最大的值
+----------+
| max(uid) |
+----------+
|    65535 |
+----------+
select sum(uid),avg(uid),min(uid),max(uid) from usertab;
                        //统计usertab表中uid的平均值,和,最小值和最大值
+----------+-----------+----------+----------+
| sum(uid) | avg(uid)  | min(uid) | max(uid) |
+----------+-----------+----------+----------+
|    77337 | 1798.5349 |        0 |    65535 |
+----------+-----------+----------+----------+

select count(id),count(name) from usertab;
                         //统计usertab表中id的个数和name的个数
+-----------+-------------+
| count(id) | count(name) |
+-----------+-------------+
|        44 |          43 |
+-----------+-------------+
                         //count统计个数时NULL空值不计入数据

select count(*) from usertab;
                         //统计usertab表中值的个数
+----------+
| count(*) |
+----------+
|       44 |
+----------+

操作结果查询:
sql查询 group by 字段名; 查询分组
select shell from usertab group by shell;
                                   //把usertab表中数据以shell分组
+----------------+
| shell          |
+----------------+
| NULL           |
| /bin/bash      |
| /bin/false     |
| /sbin/halt     |
| /sbin/nologin  |
| /sbin/shutdown |
+----------------+

sql查询 order by 字段名 排序方式; 排序  asc升序 | desc降序
select name,uid from usertab where uid>100 and uid<500 order by uid;
                     //将usertab表中uid大于100小于500的值按uid值从小到大排序
                     //不输入排序方式默认为升序asc
+-----------------+------+
| name            | uid  |
+-----------------+------+
| qemu            |  107 |
| usbmuxd         |  113 |
| pulse           |  171 |
| rtkit           |  172 |
| abrt            |  173 |
| systemd-network |  192 |
+-----------------+------+

select name,uid from usertab where uid>100 and uid<500 order by uid desc;
                     //将usertab表中uid大于100小于500的值按uid值从大到小排序
+-----------------+------+
| name            | uid  |
+-----------------+------+
| systemd-network |  192 |
| abrt            |  173 |
| rtkit           |  172 |
| pulse           |  171 |
| usbmuxd         |  113 |
| qemu            |  107 |
+-----------------+------+

limit 限制查询结果显示的行数
sql查询 limit 数字; 显示查询结果的前几行
sql查询 limit 数字1 数字2; 显示指定范围内的行
select name,shell from usertab where uid>500 limit 5;
                                    //显示usertab表中uid大于500的值中的前5行
+----------------+---------------+
| name           | shell         |
+----------------+---------------+
| polkitd        | /sbin/nologin |
| libstoragemgmt | /sbin/nologin |
| colord         | /sbin/nologin |
| saslauth       | /sbin/nologin |
| chrony         | /sbin/nologin |
+----------------+---------------+

select name,shell from usertab where uid >500 limit 3,5;
                             //显示usertab表中uid大于500的值中第4行开始的5行
                             //0表示第一行
+-----------+---------------+
| name      | shell         |
+-----------+---------------+
| colord    | /sbin/nologin |
| saslauth  | /sbin/nologin |
| chrony    | /sbin/nologin |
| geoclue   | /sbin/nologin |
| nfsnobody | /sbin/nologin |
+-----------+---------------+

having 条件 在查询结果里查找数据:
select name from usertab where id<=10 having 条件;
select name,uid from usertab where id between 20 and 30 having uid between 100 and 500;       //查找usertab表中id在20-30之间uid在100-500之间的值
+---------+------+
| name    | uid  |
+---------+------+
| abrt    |  173 |
| rtkit   |  172 |
| usbmuxd |  113 |
| qemu    |  107 |
+---------+------+

###############################################################################
第四天下午:

多表查询
复制表:备份表   快速建表

备份表:
create table xxx select * from yyy;
create table user select * from usertab;
                           //以usertab的结构和数据建一张表user
+---------+---------------------+------+-----+---------+-------+
| Field   | Type                | Null | Key | Default | Extra |
+---------+---------------------+------+-----+---------+-------+
| id      | int(3)              | NO   |     | NULL    |       |
| name    | char(150)           | YES  |     | NULL    |       |
| age     | tinyint(2) unsigned | YES  |     | 18      |       |
| passwd  | char(10)            | YES  |     | NULL    |       |
| uid     | int(8)              | YES  |     | NULL    |       |
| gid     | int(8)              | YES  |     | NULL    |       |
| homedir | char(150)           | YES  |     | NULL    |       |
| shell   | char(150)           | YES  |     | NULL    |       |
+---------+---------------------+------+-----+---------+-------+
                                     //user内容和usertab一模一样

create table user1 select name,uid,shell from user order by uid limit 5;
                                 //查找user表中name,uid,shell的信息,
                                     按照uid的值从小到大排列显示前5行,
                                        最后用此查询结果创建一张user1表
+--------+------+---------------+
| name   | uid  | shell         |
+--------+------+---------------+
| NULL   | NULL | NULL          |
| root   |    0 | /sbin/nologin |
| bin    |    1 | /sbin/nologin |
| daemon |    2 | /sbin/nologin |
| adm    |    3 | /sbin/nologin |
+--------+------+---------------+

快速建表:
create table user2 select * from user where name="1";
                               //以一个没结果的查询来复制表即为快速建表
                               //user表中没有name为1的行
+---------+---------------------+------+-----+---------+-------+
| Field   | Type                | Null | Key | Default | Extra |
+---------+---------------------+------+-----+---------+-------+
| id      | int(3)              | NO   |     | NULL    |       |
| name    | char(150)           | YES  |     | NULL    |       |
| age     | tinyint(2) unsigned | YES  |     | 18      |       |
| passwd  | char(10)            | YES  |     | NULL    |       |
| uid     | int(8)              | YES  |     | NULL    |       |
| gid     | int(8)              | YES  |     | NULL    |       |
| homedir | char(150)           | YES  |     | NULL    |       |
| shell   | char(150)           | YES  |     | NULL    |       |
+---------+---------------------+------+-----+---------+-------+

多表查询:
select 字段名列表 from 表名列表 where 条件;

create table v1 select name,uid,gid,shell from 晨练.user limit 3;
                 //用晨练库里user表中name,uid,gid,shell行的前三个值创建新表v1
+--------+------+---------------+
| name   | uid  | shell         |
+--------+------+---------------+
| root   |    0 | /sbin/nologin |
| bin    |    1 | /sbin/nologin |
| daemon |    2 | /sbin/nologin |
+--------+------+---------------+

create table v2 select name,passwd,gid,homedir from 晨练.user limit 5;
              //用晨练库里user表中的name,passwd,gid,homedir行的前5个值创建新表v2
+--------+--------+------+----------------+
| name   | passwd | gid  | homedir        |
+--------+--------+------+----------------+
| root   | x      |    0 | /root          |
| bin    | x      |    1 | /bin           |
| daemon | x      |    2 | /sbin          |
| adm    | x      |    4 | /var/adm       |
| lp     | x      |    7 | /var/spool/lpd |
+--------+--------+------+----------------+

笛卡尔集
select * from v1,v2;                    //结果为笛卡尔集,共有15行
+--------+------+---------------+--------+--------+------+----------------+
| name   | uid  | shell         | name   | passwd | gid  | homedir        |
+--------+------+---------------+--------+--------+------+----------------+
| root   |    0 | /sbin/nologin | root   | x      |    0 | /root          |
| bin    |    1 | /sbin/nologin | root   | x      |    0 | /root          |
| daemon |    2 | /sbin/nologin | root   | x      |    0 | /root          |
| root   |    0 | /sbin/nologin | bin    | x      |    1 | /bin           |
| bin    |    1 | /sbin/nologin | bin    | x      |    1 | /bin           |
| daemon |    2 | /sbin/nologin | bin    | x      |    1 | /bin           |
| root   |    0 | /sbin/nologin | daemon | x      |    2 | /sbin          |
| bin    |    1 | /sbin/nologin | daemon | x      |    2 | /sbin          |
| daemon |    2 | /sbin/nologin | daemon | x      |    2 | /sbin          |
| root   |    0 | /sbin/nologin | adm    | x      |    4 | /var/adm       |
| bin    |    1 | /sbin/nologin | adm    | x      |    4 | /var/adm       |
| daemon |    2 | /sbin/nologin | adm    | x      |    4 | /var/adm       |
| root   |    0 | /sbin/nologin | lp     | x      |    7 | /var/spool/lpd |
| bin    |    1 | /sbin/nologin | lp     | x      |    7 | /var/spool/lpd |
| daemon |    2 | /sbin/nologin | lp     | x      |    7 | /var/spool/lpd |
+--------+------+---------------+--------+--------+------+----------------+
         
select v1.*,v2.passwd,v2.gid,v2.homedir from v1,v2;
+--------+------+---------------+--------+------+----------------+
| name   | uid  | shell         | passwd | gid  | homedir        |
+--------+------+---------------+--------+------+----------------+
| root   |    0 | /sbin/nologin | x      |    0 | /root          |
| bin    |    1 | /sbin/nologin | x      |    0 | /root          |
| daemon |    2 | /sbin/nologin | x      |    0 | /root          |
| root   |    0 | /sbin/nologin | x      |    1 | /bin           |
| bin    |    1 | /sbin/nologin | x      |    1 | /bin           |
| daemon |    2 | /sbin/nologin | x      |    1 | /bin           |
| root   |    0 | /sbin/nologin | x      |    2 | /sbin          |
| bin    |    1 | /sbin/nologin | x      |    2 | /sbin          |
| daemon |    2 | /sbin/nologin | x      |    2 | /sbin          |
| root   |    0 | /sbin/nologin | x      |    4 | /var/adm       |
| bin    |    1 | /sbin/nologin | x      |    4 | /var/adm       |
| daemon |    2 | /sbin/nologin | x      |    4 | /var/adm       |
| root   |    0 | /sbin/nologin | x      |    7 | /var/spool/lpd |
| bin    |    1 | /sbin/nologin | x      |    7 | /var/spool/lpd |
| daemon |    2 | /sbin/nologin | x      |    7 | /var/spool/lpd |
+--------+------+---------------+--------+------+----------------+
         //v1表中的每一列都和v2表中的每一列匹配并显示一次,所以v2表每一列都会显示3次

select v1.*,v2.passwd,v2.gid,v2.homedir from v1,v2 where v1.name=v2.name;
+--------+------+---------------+--------+------+---------+
| name   | uid  | shell         | passwd | gid  | homedir |
+--------+------+---------------+--------+------+---------+
| root   |    0 | /sbin/nologin | x      |    0 | /root   |
| bin    |    1 | /sbin/nologin | x      |    1 | /bin    |
| daemon |    2 | /sbin/nologin | x      |    2 | /sbin   |
+--------+------+---------------+--------+------+---------+

select v1.*,v2.name,v2.passwd,v2.gid,v2.homedir 
from v1,v2 where v1.name=v2.name;
+--------+------+---------------+--------+--------+------+---------+
| name   | uid  | shell         | name   | passwd | gid  | homedir |
+--------+------+---------------+--------+--------+------+---------+
| root   |    0 | /sbin/nologin | root   | x      |    0 | /root   |
| bin    |    1 | /sbin/nologin | bin    | x      |    1 | /bin    |
| daemon |    2 | /sbin/nologin | daemon | x      |    2 | /sbin   |
+--------+------+---------------+--------+--------+------+---------+
                                //只显示v1,v2表中name字段相同的行的数据

嵌套查询:
select 字段名列表 from 表名 where 条件(select 字段名列表 from 表名 where 条件);
                                //把括号内的查询结果作为括号外查询条件
select name,uid from 晨练.user where uid>(select avg(uid) from 晨练.user);
                               //查询晨练库user表中uid大于uid平均值的值
+-----------+-------+
| name      | uid   |
+-----------+-------+
| nfsnobody | 65535 |
+-----------+-------+

select name from 晨练.user where name in (select name from db4.v1);
                                 //查看晨练库user表与db4库v1表中同时存在的用户
+--------+
| name   |
+--------+
| root   |
| bin    |
| daemon |
+--------+

链接查询:
create table v3 select name,uid,shell from 晨练.user limit 5;
+--------+------+---------------+
| name   | uid  | shell         |
+--------+------+---------------+
| root   |    0 | /sbin/nologin |
| bin    |    1 | /sbin/nologin |
| daemon |    2 | /sbin/nologin |
| adm    |    3 | /sbin/nologin |
| lp     |    4 | /sbin/nologin |
+--------+------+---------------+

create table v4 select name,uid,shell from 晨练.user limit 7;
+----------+------+----------------+
| name     | uid  | shell          |
+----------+------+----------------+
| root     |    0 | /sbin/nologin  |
| bin      |    1 | /sbin/nologin  |
| daemon   |    2 | /sbin/nologin  |
| adm      |    3 | /sbin/nologin  |
| lp       |    4 | /sbin/nologin  |
| sync     |    5 | /sbin/nologin  |
| shutdown |    6 | /sbin/shutdown |
+----------+------+----------------+

左链接:以左边的表为主显示查询结果 left join
select 字段名列表 from 表名1 left jion 表名2 on 条件;
select * from v3 left join v4 on v3.uid=v4.uid;
                        //以v3表为主显示v3表中uid与v4表中uid相等的行的所有值
+--------+------+---------------+--------+------+---------------+
| name   | uid  | shell         | name   | uid  | shell         |
+--------+------+---------------+--------+------+---------------+
| root   |    0 | /sbin/nologin | root   |    0 | /sbin/nologin |
| bin    |    1 | /sbin/nologin | bin    |    1 | /sbin/nologin |
| daemon |    2 | /sbin/nologin | daemon |    2 | /sbin/nologin |
| adm    |    3 | /sbin/nologin | adm    |    3 | /sbin/nologin |
| lp     |    4 | /sbin/nologin | lp     |    4 | /sbin/nologin |
+--------+------+---------------+--------+------+---------------+

右链接:以右边的表为主显示查询结果 right join
select 字段名列表 from 表名1 right jion 表名2 on 条件;
select * from v3 right join v4 on v3.uid=v4.uid;
                        //以v4表为主显示v3表中uid与v4表中uid相等的行的所有值
+--------+------+---------------+----------+------+----------------+
| name   | uid  | shell         | name     | uid  | shell          |
+--------+------+---------------+----------+------+----------------+
| root   |    0 | /sbin/nologin | root     |    0 | /sbin/nologin  |
| bin    |    1 | /sbin/nologin | bin      |    1 | /sbin/nologin  |
| daemon |    2 | /sbin/nologin | daemon   |    2 | /sbin/nologin  |
| adm    |    3 | /sbin/nologin | adm      |    3 | /sbin/nologin  |
| lp     |    4 | /sbin/nologin | lp       |    4 | /sbin/nologin  |
| NULL   | NULL | NULL          | sync     |    5 | /sbin/nologin  |
| NULL   | NULL | NULL          | shutdown |    6 | /sbin/shutdown |
+--------+------+---------------+----------+------+----------------+

安装phpMyAdmin:
部署环境LAMP或者LNMP
yum -y install httpd php php-mysql 
systemctl restart httpd

tar -xf phpMyAdmin-2.11.11-all-languages.tar.gz 
                                  //解包
cd phpMyAdmin-2.11.11-all-languages/
                                  //进目录
mv phpMyAdmin-2.11.11-all-languages /var/www/html/phpadmin
                                  //移动到网页目录下并改名

创建配置文件,指定管理数据库的服务器
cd /var/www/html/phpadmin
                                  //进入目录
cp config.sample.inc.php config.inc.php
                                  //拷贝模板文件创建配置文件
vim config.inc.php
                                  //修改配置文件
firefox http://192.168.4.50/phpadmin     
                                  //链接网页版数据库

创建授权:
grant 权限列表 on 库名.表名
grant all on *.* to ljw@'192.168.4.%' identified by "123456";
                   //192.168.4.0网段可以用ljw,密码123456来登录mysql

grant all on *.* to ljw@'%' identified by "123456";
                   //所有主机都可以用ljw,密码123456来登录mysql

grant select,insert on 晨练.user to ljw@'192.168.4.254' identified by "123456";
                  //192.168.4.254主机可以用ljw,密码123456来登录mysql,
                     对晨练库的user表有查询和插入权限

Query OK, 0 rows affected, 1 warning (0.00 sec)
                                      //命令执行成功的提示

###############################################################################
第五天上午:

设置管理数据库管理员root密码:操作系统管理员有权限修改

修改密码:
vim /etc/my.cnf                       //修改配置文件
set global validate_password_policy=0 //修改密码策略,只验证密码长度
set global validate_password_length=6 //修改密码策略,密码长度最短为6
:wq                                   //保存修改

mysqladmin -hlocalhost -uroot -p password "新密码"
                                      //命令行修改密码

恢复数据库管理员root登录密码:
systemctl stop mysqld                 //停用mysql

vim /etc/my.cnf                       //修改配置
skip_grant_tables                     //跳过授权
:wq                                   //保存修改

systemctl start mysqld                //启用mysql

update mysql.user set authentication_string=password("123456") where user="root" and host="localhost";     
                                     //authentication_string为登录密码字段
                                     //password()是mysql自带加密算法
flush privileges;                    //刷新修改

systemctl stop mysqld                //停用mysql

vim /etc/my.cnf                      //修改配置文件
#skip_grant_tabses                   //注释跳过授权
:wq                                  //保存修改

systemctl start mysqld               //启用mysql

mysql -uroot -p123456                //用新密码登录


用户授权:在数据库服务器上添加新的链接用户名,默认只有数据库管理员root用户在数据库服务器本机登录有授权权限,默认情况下只有数据库管理员只能从数据库本机连接服务,没有其他用户可以连接数据库
grant all on 晨练.* to lujiawen@"%" identified by "123456" [with grant option];
           //授权lujiwen在所有主机可以用123456密码登录数据库,对于晨练库有所有权限
                     //with grant option  可选添加,让lujiawen用户也拥有授权权限

授权库 mysql库记录授权信息,使用不同的表纪律不同的授权信息
user                           //记录已经添加的连接用户
db                             //记录已经添加的用户对库访问权限
tables_priv                    //记录已经添加的连接用户对表的访问权限
columns_priv                   //记录已经添加的连接用户对表字段的访问权限

查看用户权限:
show grants for 用户@"客户端地址";
show grants for root@"localhost";
                               //查看root用户在本机登录所拥有的权限
+---------------------------------------------------------------------+
| Grants for root@localhost                                           |
+---------------------------------------------------------------------+
| GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION |
| GRANT PROXY ON ''@'' TO 'root'@'localhost' WITH GRANT OPTION        |
+---------------------------------------------------------------------+

select * from mysql.user where user="root" and host="localhost"\G;
                              //查看root用户在本机登录所拥有的权限
在db50数据库操作:
grant select,insert on 晨练.* to admin@"192.168.4.%" identified by "aaaBBB111";

在db51操作:
mysql -h192.168.4.50 -uadmin -paaaBBB111

show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| 晨练		     |
+--------------------+

show grants;                        //查看登录用户所拥有的权限
+-------------------------------------------------------------+
| Grants for admin@192.168.4.%                                |
+-------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'admin'@'192.168.4.%'                 |
| GRANT SELECT,INSERT ON `晨练`.* TO 'admin'@'192.168.4.%'    |
+-------------------------------------------------------------+

在db50数据库操作:
grant all on *.* to root@"192.168.4.52" identified by "123456" with grant option;
         //授权192.168.4.52可以使用root密码123456登录本机数据库,对所有库有全部权限

在db52操作:
mysql -h192.168.4.50 -uroot -p123456
                             //在db52主机以root身份密码123456登录db52数据库

show grants;                 //登录用户拥有的权限
+------------------------------------------------------------------------+
| Grants for root@192.168.4.52                                           |
+------------------------------------------------------------------------+
| GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.4.52' WITH GRANT OPTION |
+------------------------------------------------------------------------+

权限撤销:在数据库服务器上删除

revoke 权限 on 库名 from 用户名@"客户端地址";

show grants for root@"192.168.4.52";                           
                                   //查看52主机所拥有的权限
+------------------------------------------------------------------------+
| Grants for root@192.168.4.52                                           |
+------------------------------------------------------------------------+
| GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.4.52' WITH GRANT OPTION |
+------------------------------------------------------------------------+
revoke grant option on *.* from root@"192.168.4.52";
                                   //取消授权52主机上root用户的授权权限
show grants for root@"192.168.4.52";
                                   //查看52主机所拥有的权限
+------------------------------------------------------+
| Grants for root@192.168.4.52                         |
+------------------------------------------------------+
| GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.4.52' |
+------------------------------------------------------+

用修改表记录的方式授权:
update user set Delete_priv="N" where user="root" and host="192.168.4.52"

flush privileges;                 //刷新权限

取消授权时所选的库名表名必须跟授权时完全一致;

grant all on *.* to root@"192.168.4.52" identified by "123456";
                                //授权52主机的root用户在所有库表的所有权限

revoke all on 晨练.user from root@"192.168.4.52";
                                //报错,没有这样的授权

revoke all on *.* from root@"192.168.4.52";
                                //修改成功,取消52主机上root用户的所有权限
##############################################################################
第五天下午;
                                
删除授权用户(删除可以登录的用户):

drop user root@"192.168.4.52";
                                //删除52主机上root用户的登录权限

授权用户密码的修改:

授权用户连接数据库服务器后修改连接密码
set password=password("123456");  
                                //修改登录用户的密码为123456

管理员重置连接用户的密码
set password for root@"192.168.4.50"=password("123456");
                                //管理员登录修改50主机用root登录的密码为123456

存储引擎:
存储引擎是数据库服务自带的功能程序,处理表的处理器.
每种存储引擎有不同的功能和数据存储方式

查看当前数据库服务支持的存储引擎:
show engines;
                        //查看存储引擎
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
| Engine             | Support | Comment                                                        | Transactions | XA   | Savepoints |
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
| InnoDB             | DEFAULT | Supports transactions, row-level locking, and foreign keys     | YES          | YES  | YES        |
| MRG_MYISAM         | YES     | Collection of identical MyISAM tables                          | NO           | NO   | NO         |
| MEMORY             | YES     | Hash based, stored in memory, useful for temporary tables      | NO           | NO   | NO         |
| BLACKHOLE          | YES     | /dev/null storage engine (anything you write to it disappears) | NO           | NO   | NO         |
| MyISAM             | YES     | MyISAM storage engine                                          | NO           | NO   | NO         |
| CSV                | YES     | CSV storage engine                                             | NO           | NO   | NO         |
| ARCHIVE            | YES     | Archive storage engine                                         | NO           | NO   | NO         |
| PERFORMANCE_SCHEMA | YES     | Performance Schema                                             | NO           | NO   | NO         |
| FEDERATED          | NO      | Federated MySQL storage engine                                 | NULL         | NULL | NULL       |
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+

工作中建表时如何决定适用的存储引擎:
修改数据库服务默认使用的存储引擎
systemctl stop mysqld
vim /etc/my.cnf                           //修改配置文件
default-storage-engine=myisam             //修改默认引擎为myisam
:wq                                       //保存修改
systemctl stop mysqld

建表时指定表使用的存储引擎

常用存储引擎的特点:
myisam存储引擎的特点'
支持表级锁 (客户端连接数据库服务器后,对表的数据做访问时,若表的存储引擎是myisam的话,会给整张表加锁)
不支持事务和事务回滚
每个表对应3个表文件
t1.frm 存放表结构  用 desc 表; 查看
t1.MYD 存放表数据
t1.MYI 存放表的索引信息                                 '

innodb存储引擎的特点:'
支持行级锁 (客户端连接数据库服务器后,对表的数据做访问时,若表的存储引擎是innodb的话,会只给表中被访问的行加锁)
支持外键,支持事务和事务回滚
每个表对应2个表文件
t2.frm 存放表结构  用 desc 表; 查看
t2.ibd 存放表数据和索引信息                                        '

锁粒度(锁表的范围):
行锁
表锁

锁类型:
读锁(共享锁):当对一张表执行查询(select)操作时会加读锁
写锁(排他锁或者互斥锁):当对一张表执行写(insert,update,delete)操作时会加写锁. 只允许一个写操作执行,不能同时有多个写操作

执行查询操作多的表适合用myisam存储引擎,这样节省系统资源
执行写操作多的表适合用innodb存储引擎,这样并发访问量大

事务:一次sql操作从建立连接到断开连接的访问过程叫一次事务

支持事务的表可以做事务回滚
事务回滚:一次sql操作有任意一步没有执行成功会恢复所有操作
对innodb存储引擎的表访问时,必须所有操作都成功才能完成操作

典型例子:银行汇款或转账业务
插卡-->输入密码-->登录成功-->转账-->输入对方账号-->输入金额-->确定-->转账成功-->退卡   (一次事务)
任意一步出错,修改正确操作继续

innodb存储引擎的表有对应的事务日志文件记录所有sql操作
cd /var/lib/mysql
ibdata1                            
ib_logfile0
ib_logfile1

事务的特点:ACID 
A:原子性   //事务的整个操作时一个整体,不可分割,要么全部成功,要么全部失败
C:一致性   //事务操作的前后,表中的记录没有变化
I:隔离性   //事务操作是相互隔离不受影响的
D:持久性   //数据一旦提交,不可改变,永久改变表数据

show variables like "autocommit";       //查看自动提交状态
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| autocommit    | ON    |
+---------------+-------+

set autocommit=off;                     //关闭自动提交功能
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| autocommit    | OFF   |
+---------------+-------+

本机操作:
select name,passwd from user where name="ljw";
+------+--------+
| name | passwd |
+------+--------+
| ljw  | 123    |
+------+--------+
update user set passwd=321 where name="ljw";
+------+--------+
| name | passwd |
+------+--------+
| ljw  | 321    |
+------+--------+

其他主机连接本机数据库操作:
select name,passwd from user where name="ljw";
+------+--------+
| name | passwd |
+------+--------+
| ljw  | 123    |
+------+--------+

本机操作回滚:
rollback;
+------+--------+
| name | passwd |
+------+--------+
| ljw  | 123    |
+------+--------+

本机操作:
select * from user where name="ljw";
+----+------+------+--------+------+------+-----------+-----------+
| id | name | age  | passwd | uid  | gid  | homedir   | shell     |
+----+------+------+--------+------+------+-----------+-----------+
| 43 | ljw  |   18 | 321    | 1002 | 1001 | /home/ljw | /bin/bash |
+----+------+------+--------+------+------+-----------+-----------+

delete from user where name="ljw";        //删除name字段ljw行

select * from user where name="ljw";      //查询没有结果
Empty set (0.00 sec)

其他主机操作:
select * from user where name="ljw";
+----+------+------+--------+------+------+-----------+-----------+
| id | name | age  | passwd | uid  | gid  | homedir   | shell     |
+----+------+------+--------+------+------+-----------+-----------+
| 43 | ljw  |   18 | 321    | 1002 | 1001 | /home/ljw | /bin/bash |
+----+------+------+--------+------+------+-----------+-----------+

本机操作提交:
commit;                                   //提交

其他主机操作:
select * from user where name="ljw";
Empty set (0.00 sec)                      //查询没有结果


1.数据库备份的方式
物理备份:备份库和表对应系统文件
cp -r /var/lib/mysql/mysql /dbdir           //备份mysql库
物理恢复:
cp -r /dbdir /var/lib/mysql/mysql           //恢复mysql库
chown -R mysql:mysql /var/lib/mysql/mysql   //将mysql属主和属组改成mysql

逻辑备份:执行备份命令时,根据备份的库表生成对应的sql命令,把命令保存到指定的文件里.
        恢复时执行保存sql命令的备份文件,把数据写会数据库里
                          
2.数据备份策略
完全备份:备份所有数据(通常包括3类对象:表中所有数据,库中所有数据,服务器上所有数据)

只备份新产生的数据:
差异备份:备份自完全备份后所有新产生的数据
增量备份:备份自上次备份后所有新产生的数据

###############################################################################
第六天上午:

lock tables 表名 read|write;                //加读(写)锁
unlock tables 表名;                         //解锁

完全备份和完全恢复:
完全备份:mysqldum
mysqldump -uroot -p123456 库名 > /root/beifen.sql

库名的表示方式:
--all-databases 或者 -A                     //所有库所有表
库名                                        //单个库下的所有表        
库名 表名                                   //一个库下的一张表
-B 库名1 库名2                              //备份某几个库的数据

完全恢复:mysql
1.mysql -uroot -p123456 库名 < /root/beifen.sql
                                           //命令操作
2.mysq -uroot -p123456
  source /root/beifen.sql                  //数据库操作

'缺点:mysqldump备份和恢复数据时会锁表                                       '

增量备份:
1.启用mysql服务自带的binlog日志文件
日志介绍:时服务日志文件中的一种,默认没有开启,记录除查询之外的sql命令
binlog日志的使用:
启用日志:
vim /etc/my.cnf
server_id=50(主机名)
binlog-format="mixed"
:wq
systemctl restart mysqld

db50-bin.000001 大于500M之后 
自动生成第二个日志文件 db50bin.000002       //日志文件
db50-bin.index                            //索引文件

查看日志内容:mysqlbinlog
日志记录格式:
show variables like "binlog_format";
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| binlog_format | MIXED |
+---------------+-------+

日志文件默认存在/var/lib/mysql下
###############################################################################
第六天下午:

自定义binlog名称和存储路径
mkdir /logdir
chown mysql:mysql /logdir            //创建目录,修改属主和属组为mysql

vim /etc/my.cnf
bin-log=/logdir/db50                 //修改配置文件,日志默认目录改为/logdir/db50
:wq

systemctl restart mysqld             //重启服务

日志记录sql命令的格式:
偏移量
时间点

--start-position=数字
--stop-position=数字

--start-datetime="yyyy-mm-dd hh:mm:ss"
--stop-datetime="yyyy-mm-dd hh:mm:ss"

使用日志文件恢复数据:
执行日志文件里的sql命令恢复数据
mysqlbinlog 选项 日志文件名 | mysql -uroot -p123456
mysqlbinlog --start-position=18581 --stop-position=19865 db50.000001 | mysql -uroot -p123456
                   //在数据库中恢复日志at 18581 到 at 19865 之间的操作
mysqlbinlog --start-datetime="2018-07-17 15:06:12" --stop-datetime="2018-07-17 15:11:47" db50.000001 | mysql -uroot -p123456
                  //在数据库中恢复日志时间2018-07-17 15:06:12 
                       到 2018-07-17 15:11:47 之间的操作

手动生成新的日志文件:
1. mysqldump -uroot -p123456 --flush-logs v1 > /bakdir/beife.sql
                                  //在命令行操作,完全备份后会生成新的日志文件
2. flush logs;                    //在数据库操作,可以生成新的日志文件

3. mysql -uroot -p123456 -e "flush logs"
                                  //在命令行操作,跟第二条效果一样
4. systemctl restart mysqld
                                  //重启服务可以生成新的日志文件

当日志文件有多个的时候,日志会写入编号更大的文件

show master status;               //查看正在使用的日志文件和偏量

删除已有的日志文件:
purge master logs to "db50.000005";
                                  //删除该序号之前的日志文件

reset master;                     //删除所有日志文件并重新创建一个

2.安装第三方软件percona提供的命令innobackupex

yum -y install perl-DBD-mysql perl-Digest-MD5

rpm -ivh libev-4.15-1.el6.rf.x86_64.rpm  

rpm -ivh percona-xtrabackup-24-2.4.7-1.el7.x86_64.rpm

命令格式:innobackupex  选项
选项:
--user                     //用户名
--password                 //密码
--host                     //主机名
--port                     //端口号
--databases                //"库名" | "库名 库名" | "库名.表名"
--no-timestamp             //不用日期命名备份文件储存的子目录

完全备份:
innobackupex --user root --password 123456 --databases="mysql performance_schema sys gamedb" /like --no-timestamp
                //以root用户123456密码备份所有数据库数据到/like目录下

/like中的文件:
xtrabackup_checkpoints                 //备份类型

完全恢复:
--apply-log                            //回滚
--copy-back                            //拷贝

innobackupex --user root --password 123456 --databases="mysql performance_schema sys gamedb" --apply-log /like

innobackupex --user root --password 123456 --databases="mysql performance_schema sys gamedb" --copy-back /like

要求数据库目录/var/lib/mysql必须是空的

准备恢复数据:
把备份目录下数据拷贝回数据库目录下,修改数据库目录属主和属组为mysql
重启数据库服务



增量备份和恢复:

从完全备份文件里恢复单个表:




























































































































































































































































































































systemctl restart  mysql



































































































































































































systemctl restart  mysql














