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
