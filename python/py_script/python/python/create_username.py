import sys
import subprocess
import genpass   #自己之前已经创建,且路径很严格★★★★★★★★★★★★



def  adduser(username, passwd, fname):
    info = """
    username: %s
    password: %s
    """

    subprocess.call('useradd %s' % username,shell=True)
    subprocess.call(
        'echo  %s | passwd --stdin  %s' % (passwd,username),
        shell=True
    )
    with  open(fname,'a') as fobj:
        fobj.write(info %(username, passwd))

if __name__ == '__main__':
    username = sys.argv[1]
    passwd = genpass.gen_pass()
    adduser(username,passwd,'/tmp/userinfo.txt')