
# a = [0,1]
# b = a[0] + a[1]
# a.append(int(b))
# print(a)



# alist = [0,1]
# for a  in range(len(alist)):
#     print('%s:%s'%(a,alist[a]))

#斐波那契数列
a = [0,1]
l = int(input('length: '))
for i  in  range(l-2):
    a.append(a[-1]+a[-2])
    print(a)
print(a)







