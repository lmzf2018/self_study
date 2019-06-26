#!/usr/bin/python3
import subprocess
import sys
import random, string  # 调用random、string模块


def GenPass(n=15):
    src_digits = string.digits  # string_数字  '0123456789'
    src_uppercase = string.ascii_uppercase  # string_大写字母 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    src_lowercase = string.ascii_lowercase  # string_小写字母 'abcdefghijklmnopqrstuvwxyz'
    src_special = string.punctuation  # string_特殊字符 '!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'

    # sample从序列中选择n个随机独立的元素，返回列表
    num = random.sample(src_digits, 1)  # 随机取1位数字
    lower = random.sample(src_uppercase, 1)  # 随机取1位小写字母
    upper = random.sample(src_lowercase, 1)  # 随机取1位大写字母
    special = random.sample(src_special, 1)  # 随机取1位大写字母特殊字符
    other = random.sample(string.ascii_letters + string.digits + string.punctuation, n-4)  # 随机取n-4位
    # 生成字符串
    # print(num, lower, upper, special, other)
    pwd_list = num + lower + upper + special + other
    # print(pwd_list)
    # shuffle将一个序列中的元素随机打乱，打乱字符串
    random.shuffle(pwd_list)
    # 列表转字符串
    password_str = ''.join(pwd_list)
    print(password_str)


# def adduser(username, password, fname):
#     data = """user information:
# %s:%s
# """
#     subprocess.call('useradd %s' % username, shell=True)  # subprocess.call,可以使用所有的shell命令
#     subprocess.call(
#         'echo %s | passwd --stdin %s' % (password, username),
#         shell=True
#     )
#     with open(fname, 'a') as fobj:
#         fobj.write(data % (username, password))


def adduser(username, password):
    subprocess.call('useradd %s' % username, shell=True)  # subprocess.call,可以使用所有的shell命令
    subprocess.call(
        'echo %s | passwd --stdin %s' % (password, username),
        shell=True
    )

def add_sudoer(username):
    subprocess.call('sed  -i  "/^root/a\%s    ALL=(ALL)       ALL" /etc/sudoers' % username,  shell=True)


if __name__ == '__main__':
    # username = sys.argv[1]
    username = input("请输入要设定的用户名： ")
    password = int(input("请输入要设定的密码数： "))
    GenPass(password)
    adduser(username, password)
    add_sudoer(username)

