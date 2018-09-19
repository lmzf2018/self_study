import random
all = ['石头','剪刀','布']
win_list = [['石头','剪刀'],['剪刀','布'],['布','石头']]
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
    print('You: %s ,Com: %s'%(p,c))
    if c == p:
        print('\033[32;1m平局\033[0m')
    elif [p,c] in win_list:
        pwin += 1
        print('\033[31;1mYou win!!!\033[0m')
    else:
        cwin += 1
        print('\033[31;1mYou lose\033[0m')
if  pwin > cwin:
    print('You win')
else:
    print('You lose!!!!!!')