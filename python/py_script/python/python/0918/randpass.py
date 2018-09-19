import  random
def random_create_passwd(pass_length):
    passwd = ''
    str = 'dsakdpoiweopr^&)_(833HJG%$##(@!~":"78eFGHF2*6t45gv^%$'
    length = len(str) - 1
    for  i  in  range(pass_length):
        passwd += str[random.randint(0,length)]

    return passwd
#
# n = int(input('Please import your pass_length: '))
n = int(input('Password length: '))

c = random_create_passwd(n)
print(c)





