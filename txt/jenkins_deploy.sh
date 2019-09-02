#!/bin/bash
# 配置java环境变量
JAVA_HOME=/usr/local/jdk1.8.0_201
JRE_HOME=/usr/local/jdk1.8.0_201/jre
CLASS_PATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
export JAVA_HOME JRE_HOME CLASS_PATH PATH
 
# 配置tomcat环境变量
CATALINA_BASE="/mnt/apache-tomcat-8.5.24"
CATALINA_HOME="/mnt/apache-tomcat-8.5.24"
TOMCAT_HOME="/mnt/apache-tomcat-8.5.24"
export CATALINA_BASE CATALINA_HOME TOMCAT_HOME

echo "stopping tomcat_operation......"
#关闭tomcat
port=8005
根据端口号查询对应的pid
pid=$(netstat -nlp | grep :$port | awk '{print $7}' | awk -F"/" '{ print $1 }');
#杀掉对应的进程，如果pid不存在，则不执行
if [  -n  "$pid"  ];  then
    kill  -9  $pid;
fi

#删除tomcat旧war包
#rm -rf /home/wwwroot/easywits-operation/tomcat-easywits-operation/webapps/easywits
#rm -rf /home/wwwroot/easywits-operation/tomcat-easywits-operation/webapps/easywits.war
#复制war包到tomcat/webapps目录,并重命名
cp  /mnt/deploy_document/demo-0.0.1-SNAPSHOT.war    /mnt/apache-tomcat-8.5.24/webapps/demo.war

# 文件名 + 当前日期时间错,备份发布文件包
#DEPLOY_DATE=`date +%Y%m%d%H%M%S`
#DEPLOY_FILE_NAME=easywits-op-server_$DEPLOY_DATE.war
#mv /home/wwwroot/easywits-operation/deploy_history/easywits.war /home/wwwroot/easywits-operation/deploy_history/$DEPLOY_FILE_NAME
#rm -rf /home/wwwroot/easywits-operation/deploy_history/*
echo "restarting tomcat_easywits_operation......"
sleep 5
/mnt/apache-tomcat-8.5.24/bin/startup.sh
