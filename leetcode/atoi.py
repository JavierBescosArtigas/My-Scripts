#https://leetcode.com/problems/string-to-integer-atoi/
print("string to 32.bits integer \n")
def myAtoi( s: str) -> int:
        s = s.lstrip()
        if not s:
            print('cadena vacía')
            return 1
        if (s[0] == '+') | (s[0] == '-'):
            digitos = s[0]+'0'
            for letra in s[1:]:
                if letra.isnumeric():
                    digitos += letra
                else:
                    break
        else:
            digitos = '0'
            for letra in s[0:]:
                if letra.isnumeric():
                    digitos += letra
                else:
                    break
        digitos = float(digitos)
        if digitos > (2*31 -1):
            digitos = int(2**31 - 1)
            return digitos
        elif digitos < (-1 * 2**31):
            digitos = int(-2**31)
            return digitos
        else:
            return int(digitos)
print('-42-> {}'.format(myAtoi('-42')))
print('4193 with words-> {}'.format(myAtoi('4193 with words'))) #dont work
print('     -42-> {}'.format(myAtoi('     -42')))

