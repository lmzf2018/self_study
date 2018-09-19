import shutil
f1 = open('/etc/hosts','rb')
f2 = open('/tmp/ok','wb')
shutil.copyfileobj(f1,f2)
f1.close()
f2.close()
##########################################

shutil.copyfile('/etc/passwd','/tmp/hao1')

shutil.copy('/etc/hosts','/mnt')
shutil.copy2('/etc/passwd','/var/tmp')  # cp -p