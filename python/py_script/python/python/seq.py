alist = ['zhangsan','lisi','wangwu']


for ind  in range(len(alist)):
    print('%s: %s'% (ind,alist[ind]))
# 0: zhangsan
# 1: lisi
# 2: wangwu


print(list(enumerate(alist)))
# [(0, 'zhangsan'), (1, 'lisi'), (2, 'wangwu')]

for item in enumerate(alist):
    print('%s:%s' %(item[0],item[1]))
# 0:zhangsan
# 1:lisi
# 2:wangwu


for ind,val in enumerate(alist):
    print('%s:%s' %(ind,val))
# 0:zhangsan
# 1:lisi
# 2:wangwu


print(list(reversed(alist)))
#['wangwu', 'lisi', 'zhangsan']

print(sorted(alist))
#['lisi', 'wangwu', 'zhangsan']

blist = 'dsadjkhsajkdjslfkdlsafkdslk'
print(list(reversed(blist)))

clist = '231658794'
print(list(reversed(clist)))


a = "你好"
print(a.encode('utf-8'))  #转成bytes类型
# b'\xe4\xbd\xa0\xe5\xa5\xbd'

b = a.encode('utf-8')
print(b.decode('utf-8'))  #装换成字符串类型
# 你好



