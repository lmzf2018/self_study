import random
all = ['石头','剪刀','布']
win_list = ['石头,剪刀','剪刀,布','布,石头']
c = random.randint(0,2)
cwin = 0
pwin = 0

prompt = """(0)石头
(1)剪刀
(2)布
请输入数字(0/1/2): """

while cwin < 2 and pwin < 2:
    ind = int(input(prompt))
    c = random.choice(all)
    p = all[ind]
    if c == p:
        print('平局')
    elif [p,c] in win_list:
        print('You win!!!')
        pwin += 1
    else:
        print('You lose')
        cwin += 1
        break




