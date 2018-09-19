import random
a = random.randint(1,10)
b = True
while  b:
   c = int(input('You  guess  the number: '))
   if c > a:
      print('大')
   elif c < a:
      print('小')
   else:
      print('ok')
      b = False
