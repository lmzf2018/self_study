astr = 'hello'
alist = ['bob','lucy']
atuple = (100,200,300)
adict = {'name':'zhangsan','age':25}


for ch in astr:
    print(ch)

for name in  alist:
    print(name)

for i in atuple:
    print(i)

for key in adict:
    print('%s:%s'%(key,adict[key]))
####################################################
print('#'*20)
for  i  in range(10):
    print(i)

print('#'*20)
for i  in range(6,10):
    print(i)


print('#'*20)
for  i in range(1,10,2):
    print(i)

print('#'*20)
for i in range(10,0,-1):
    print(i)
####################################################
print('*'*20)
alist = ['bob','Lucy','hao','good','jerry']
for a  in range(len(alist)):
    print('%s:%s'%(a,alist[a]))


####################################################




