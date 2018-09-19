import   random
all_win = [['石头','剪刀'],['剪刀','布'],['布','石头']]
#ind = random.randint(0,2)
all = ['石头','剪刀','布']
pwin = 0
cwin = 0
prompt = """(0)石头
(1)剪刀
(2)布
请输入指定数字0/1/2: """

while  pwin < 2  and cwin < 2:
      ind = int(input(prompt))
      p = random.choice(all)
      c = all[ind]
      print('Your choice:%s,Computer chice:%s'%(c,p))
      if p == c:
         print('\033[32;1m平局\033[0m')
      elif [c,p] in all_win:
         print('\033[31;1mYou win\033[0m')
         cwin += 1
      else:
         print('\033[31;1mYou  lose\033[0m')
         pwin += 1
     
