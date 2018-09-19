import  os
def get_fname():
    while True:
        fname = input('file  name: ')
        if not  os.path.exists(fname):
            break
        print('%s exits, please retry'%fname)

    return fname

def get_content():
    content = []
    print('请输入内容(输入end结束): ')
    while True:
        line = input('>')

        if line == 'end':   #注意双等号
            break
        content.append(line)

    return content


def wfile(fname,content):
    with open(fname,'w') as fobj:  #不同函数的fname没有关系,可以用不同的变量
        fobj.writelines(content)



if __name__ == '__main__':
    fname = get_fname()
    content = get_content()
    wfile(fname,content)