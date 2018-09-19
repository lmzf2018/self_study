result = 0
counter = 0

while counter < 100:
    counter  += 1
    if counter % 2:
    #if counter % 2 == 1:   # counter % 2 结果不是0就是1, 0为False,1为Ture
        continue

    result +=counter

print(result)