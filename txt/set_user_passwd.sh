#!/bin/bash
read -p "请输入要设定的用户: " user
read -p "请输入要设定的密码位数: " number

#添加用户
useradd  ${user}


if [ $? -eq 0 ];then
   echo "user ${user} is created successfully!!!"
else
   echo "user ${user} is created failly!!!"
   exit 1
fi

#生成随机密码，并给用户设置密码
user_passwd=`tr -dc '_A-Z#\-+=a-z(0-9%^>)]{<|' </dev/urandom | head -c ${number}; echo`
echo $user_passwd | passwd  --stdin ${user}   &>/dev/null


if [ $? -eq 0 ];then
   echo "${user}'s password is set successfully"
else
   echo "${user}'s password is set failly!!!"
fi

echo "##########################################"
echo "设定的账户是:${user};密码是:${user_passwd}"
echo "##########################################"



