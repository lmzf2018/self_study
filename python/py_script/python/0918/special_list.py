# [3 + 2]
# [3 + 2 for i  in range(5)]
# [3 + i for i  in range(5)]
# [3 + i for i  in range(1,10)]
# [3 + i for i  in range(1,10) if i%2 == 0]
#
# ['192.168.1.%s'% i in range(1,255)]

print([3 + 2])
print([3 + 2 for i  in range(5)])
print([3 + i for i  in range(5)])
print([3 + i for i  in range(1,10)])
print([3 + i for i  in range(1,10) if i%2 == 0])

print(['192.168.1.%s'% i for i in range(1,255)])