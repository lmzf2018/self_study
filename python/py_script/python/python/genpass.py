from  random  import  choice
from string import ascii_letters,digits

def gen_pass(n=8):

    # all_choice = '131234567890qwertyuiopasdffghjklcvbnm,,./!@#$%^&*()_+'
    all_choice = ascii_letters + digits
    result = ''

    for i in range(n):
        ch = choice(all_choice)
        result += ch

    return result


if __name__ == '__main__':
    print(gen_pass())
    print(gen_pass(88))