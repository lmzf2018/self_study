# if 10 > 2 :
#     print('yes')
#     print('ok')
#
# if -0.0:
#     print('yes')


#例子1
import getpass
a = input('username: ')
b = getpass.getpass('passwd: ')
if a == 'bob' and b == '123456':
    print('Login successful')
else:
    print('Login incorrect')



#例子2
a = input('username: ')
b = input('passwd: ')
if a == 'bob' and b == '123456':
    print('Login successful')
else:
    print('Login incorrect')


#例子3
a = input('username: ')
b = int(input('passwd: '))
if a == 'bob' and b == 123456:
    print('Login successful')
else:
    print('Login incorrect')