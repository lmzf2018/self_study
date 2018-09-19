import random
print( random.randint(1,10) )        # 产生 1 到 10 的一个整数型随机数
print( random.random() )             # 产生 0 到 1 之间的随机浮点数
print( random.uniform(1.1,5.4) )     # 产生  1.1 到 5.4 之间的随机浮点数，区间可以不是整数
print( random.choice('tomorrow') )   # 从序列中随机选取一个元素
print( random.randrange(1,100,2) )   # 生成从1到100的间隔为2的随机整数


import random

all_choice = ['石头','剪刀','布']
win_list = [['石头','剪刀'],['布','石头'],['剪刀','布']]
prompt = """(0)石头
(1)剪刀
(2)布
请输入数字(0/1/2): """
pwin = 0
cwin = 0

while pwin < 2 and cwin < 2:
    ind = int(input(prompt))
    computer = random.choice(all_choice)
    player = all_choice[ind]

    print("Your choice: %s, computer choice: %s"%(player, computer))
    if player == computer:
        print('\033[32;1m平局\033[0m')
    elif [player,computer] in win_list:
        pwin +=1
        print('\033[31;1mYou win!!!\033[0m')
    else:
        cwin +=1
        print('\033[31;1mYou lose\033[0m')
