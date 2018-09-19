def gen_fib(l):    #l为形参
    fib = [0,1]
    for i  in  range(l-2):
        fib.append(fib[-1] + fib[-2])

    return fib

a = gen_fib(10)      # 10为实参
print(a)
n = int(input('Length: '))
b = gen_fib(n)
c = [i * 2 for i in b]
print(c)