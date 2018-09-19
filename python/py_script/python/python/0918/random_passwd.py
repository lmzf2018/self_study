# import  random
# def passwd_func():
#     all_choice = [['shhkjhyg'],['3746wreq'],[')*^&sdsd'],['/*-*jkd'],['4567&^%g']]
#     a = random.randint(0,4)
#     b = random.choice(all_choice[a])
#     return b
#
# print(passwd_func())



import  random

def pass_func(b=8):
    a = random.randint(0,25)
    str = '01dsa8#$%#%$$#^&&&*(ddfs7fsd89hda^&*^&*()_+)_+**)*)*57$%$348DS9)(*(()I&*(wqeiwqie98fdsF(i)&*()*guiyuisx*(()*()#$@#$skjdhsla;dlsafjkl;dsfdjs;al'

    return str[a:a+b]


n = int(input('Password length: '))
b = pass_func(n)
print(b)