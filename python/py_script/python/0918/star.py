# python3
# >>> import os
# >>> os.getcwd()
# '/root/python/0918'
# >>> import  star
# >>> star.hi
# 'hello world'
# >>> star.pstar()
# **************************************************
# >>> star.pstar(10)
# **********

hi = 'hello world'

def pstar(n=50):
    print('*'*n)

if __name__ == '__main__':
    pstar()

#使用import导入模块
# •  模块被导入后,程序会自动生成pyc的字节码文件以提升性能
# •  模块属性通过“模块名.属性”的方法调用
# •  如果仅需要模块中的某些属性,也可以单独导入


# •  一个模块只被加载一次,无论它被导入多少次
# •  只加载一次可以阻止多重导入时代码被多次执行
# •  如果两个文件相互导入,防止了无限的相互加载
# •  模块加载时,顶层代码会自动执行,所以只将函数放
# 入模块的顶层是良好的编程习惯
# [root@room 0918]# pwd
# /root/python/0918
# [root@room 0918]# python3  foo.py
# __main__
# [root@room 0918]# python3  bar.py
# foo
