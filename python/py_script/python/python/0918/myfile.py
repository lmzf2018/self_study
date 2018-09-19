# # # #open('/tmp/a.txt')   #默认以r方式读
# # # f = open('/tmp/passwd')
# # # data = f.read()
# # # f.close()
# # # print(data)
# # #
# # # ################################################
# # #
# # # d = open('/tmp/passwd')
# # # data = d.read()    #读到文件结束
# # # print(data)
# # # data = d.read()    #文件指针已经移到结尾,没有可读数据
# # # print(data)        #无内容
# # # d.close()
# #
# # # ##################################################
# # # d = open('/tmp/passwd')
# # # da = d.read()    #读到文件结束
# # # print(da)
# # # da = d.read()    #文件指针已经移到结尾,没有可读数据
# # # print(da)        #无内容
# # # d.close()
# #
# # ##################################################
# # f = open('/tmp/passwd')
# # f.read(1)
# # f.read(4096)
# # f.readline()
# # f.readlines()
# # f.close()
# # #f = open('/tmp/passwd')
# # f = open('/tmp/passwd')
# # print(f.read(1))
# # f.read(4096)
# # f.readline()
# # f.readlines()
# # f.close()
# #
# #
# # f = open('/tmp/passwd')
# # for line in  f:
# #     print(line,end='')
# # f.close()
# #
# # #############################################
# # #cp /bin/ls   /tmp/list
# # f = open('/tmp/list', 'rb')
# # f.read(10)
# # f.close()
# #
# #
#
#
#
# #############################################
#
# f =  open('/tmp/ab.txt','w')
# # print(f.write('hello world\n'))
# # # print(f.flush())
# print(f.writelines(['2nd line.\n','3nd line.\n']))
# # # print(f.close())

################################################

# with  open('/tmp/a.txt','w') as  f:
#     print(f.write('my test.\n'))

#####################################################

f = open('/tmp/passwd','rb')
print(f.tell())
print(f.readline())
print(f.tell())
print(f.read(5))
print(f.seek(3,0))
print(f.read(3))
print(f.seek(9,1))
print(f.read(9))
print(f.seek(-6,2))
print(f.read(5))

######################################################
###以下是python3交互模式
# >>> import  sys
# >>> b = sys.stdin.readline()
# hello world
# >>> b
# 'hello world\n'
# >>> print(sys.stdout.write('hello world!\n'))
# hello world!
# 13
# >>> print(sys.stderr.write('hello world!\n'))
# hello world!
# 13
# >>>


import  sys
b = sys.stdin.readline()
print(sys.stdout.write('hello world!\n'))
print(sys.stderr.write('hello world!\n'))


###############################################################




















