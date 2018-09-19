# yn = input('continue(y/n)?')
# while yn not in ['n','N']:
#     print('working...')
#     yn = input('continue(y/n)?')
#
# DRY: Don't Repeat Youself


while True:
    yn = input('continue(y/n)?')
    if yn in ['n','N']:
        break
    print('woring...')

