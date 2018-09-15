# if 10 > 2 :
#     print('yes')
#     print('ok')
#
# if -0.0:
#     print('yes')
import getpass
a = input('username: ')
b = getpass.getpass('passwd: ')
if a == 'bob' and b == '123456':
    print('Login successful')
else:
    print('Login incorrect')

