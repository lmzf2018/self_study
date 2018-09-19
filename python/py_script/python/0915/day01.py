print("hello")
print("xiaoluzi")
if 3 > 0:
    print("yes")
    print("o55","kjash")  #默认各项之间用空格
    print('hello','world', end='#####')
    print('hello','world', sep='***')
    print('hello', 'world', sep='???')
    print('hello' + 'world')

n = input('number: ')  #屏幕提示number: 用户输入的内容赋值给n
print(n)

a = int(n) + 10  # 可以将字符串数值转换成相应的整数
print(a)

b = n + str(15)  # srt可以将其他数据转换成字符
print(b)

