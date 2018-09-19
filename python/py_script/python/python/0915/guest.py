import  random
number = random.randint(1,100)
count = 0

while count < 5:
    answer = int(input('guest the number: '))
    if answer > number:
        print('猜大了')
    elif answer < number:
        print('猜小了')
    else:
        print('猜对了')
        break
    count +=1
else:    #循环正常结束才执行,如果循环被break掉,就不执行了
    print('The  number:', number)