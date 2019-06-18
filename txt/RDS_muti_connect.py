# 首先安装模块
# pip3 install pymysql
# pip3 install sshtunnel
# 参考网址：
# https://my.oschina.net/longquan/blog/1590608
# https://blog.csdn.net/qixizhuang/article/details/83147221

import pymysql
from sshtunnel import SSHTunnelForwarder


number = int(input('''[1]: 海亮-专用数据库-0ld(rm-bp11r7299352hc0ld);
[2]: 浙大-新零售数据库-9vy(rm-bp1ds482x2qti79vy);
[3]: 综合-GolivePlus数据库-xkv(m-bp19xx98d53ym3xkv);
[4]: 物联-门禁微服务数据库-ot7(rm-bp17rjrv2ej8uq0t7);
[5]: 物联部-智能用电数据库-612(rm-bp191904oddzq9612);
[6]: 青橄榄-JAVA专用数据库-mxy(rm-bp1g581dfpo4qsmxy);
请输入数字[1|2|3|4|5|6]:'''))

if number == 1:
    RDS_name = 'rm-bp11r7299352hc0ld1o.mysql.rds.aliyuncs.com'
    RDS_passwd = 'ft^G716O6liV#e0=wgqr5'
elif number == 2:
    RDS_name = 'rm-bp1ds482x2qti79vyfo.mysql.rds.aliyuncs.com'
    RDS_passwd = 'qgl@617jsb'
elif number == 3:
    RDS_name = 'rm-bp19xx98d53ym3xkv2o.mysql.rds.aliyuncs.com'
    RDS_passwd = 'sF34#gd93'
elif number == 4:
    RDS_name = 'rm-bp17rjrv2ej8uq0t7ao.mysql.rds.aliyuncs.com'
    RDS_passwd = 'doorCtl#2019%gDn617'
elif number == 5:
    RDS_name = 'rm-bp191904oddzq9612to.mysql.rds.aliyuncs.com'
    RDS_passwd = 'ZnyD#617_gOliVejt298'
elif number == 6:
    RDS_name = 'rm-bp1g581dfpo4qsmxy9o.mysql.rds.aliyuncs.com'
    RDS_passwd = 'UdeUUe&qMaVOvR8g@2019_617'
print()


with SSHTunnelForwarder(
        # ('跳板机外网IP', 端口),
        ('112.124.48.228', 22),
        ssh_username="yangq",
        ssh_password="Yy2733752",
        local_bind_address=('0.0.0.0', 10022),
        remote_bind_address=(RDS_name, 3306)) as server:  # RDS的数据库地址

    conn = pymysql.connect(host='127.0.0.1',  # 此处必须是是127.0.0.1
                           port=10022,
                           user='root',
                           passwd=RDS_passwd, )  # RDS的user和passwd

    print('---创建连接完成---')

    cursor = conn.cursor()
    print('---获取光标完成---')

    # cursor.execute("show databases")
    # print(cursor.fetchall())
    # conn.close()
    cursor.execute("show databases")
    print("数据库：",cursor.fetchall())
    print()
    conn.close()

    database_grant = input('''all:所有权限;
select：查看权限；
请选择 all/select：''')
    print()

    database_name = input("请输入数据库名：")
    # cmd1 = "SELECT * FROM information_schema.SCHEMATA where SCHEMA_NAME=" + "'"+database_name+"'"
    # if not cursor.execute(cmd1):
    #     sql_create_db = "create database " + '"'+database_name+'"'
    #     cursor.execute(sql_create_db)
    # cmd2 = "CREATE DATABASE IF NOT EXISTS " + '"'+database_name+'"'
    # cursor.execute(cmd2)
    # print()

    database_user_name = input("请输入用户名：")
    database_passwd = input("请输入数据库密码：")
    exe_cmd = "grant " + database_grant + " on " + database_name + ".* to " + database_user_name + "@'%'" + " identified by " + '"'+database_passwd+'"'
    print(exe_cmd)
    print()

    # 在引号中引入变量的方法
    # print('"' + database_passwd + '"')

    cursor.execute(exe_cmd)
    cursor.execute("flush privileges")
    print('------数据库授权完成------')
    print("数据库地址：%s;数据库名：%s;数据库用户名：%s；数据库密码：%s" % (RDS_name, database_name, database_user_name,database_passwd))
    conn.close()