# method one
import random
a = ['stone','scissors','cloth']
b = random.randint(0,2)
c = a[b]
print(c)
d = input('请出手势: ')
if c == 'stone' and d == 'scissors' or c == 'cloth' and d == 'stone' or c == 'scissors' and d == 'cloth':
    print('you lose')
elif c == d:
    print('equal')
else:
    print('you win')



# method two
import random
computer = random.choice(['stone','scissors','cloth'])
player = input('请出手势: ')
print("Your choice: %s,computer's choice:%s"%(player,computer))
if player == 'stone':
    if computer == 'stone':
        print('equal')
    elif computer == 'scissors':
        print('you win')
    else:
        print('you lose')
elif player == 'scissors':
    if computer == 'scissors':
        print('equal')
    elif computer == 'stone':
        print('you lose')
    else:
        print('you win')
elif player == 'cloth':
    if computer == 'cloth':
        print('equal')
    elif computer == 'scissors':
        print('you lose')
    else:
        print('you win')



# method three

import random

all_choice = ['石头','剪刀','布']
win_list = [['石头','剪刀'],['布','石头'],['剪刀','布']]
prompt = """(0)石头
(1)剪刀
(2)布
请输入数字(0/1/2): """

ind = int(input(prompt))
computer = random.choice(all_choice)
player = all_choice[ind]

print("Your choice: %s, computer choice: %s"%(player, computer))
if player == computer:
    print('\033[32;1m平局\033[0m')
elif [player,computer] in win_list:
    print('\033[31;1mYou win!!!\033[0m')
else:
    print('\033[31;1mYou lose\033[0m')






