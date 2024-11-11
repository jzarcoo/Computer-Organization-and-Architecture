# Calcula el coeficiente binomial de n en k
def coeficiente_binomial(n, k):
    if k == 0 or k == n:
        return 1
    else:
        return coeficiente_binomial(n - 1, k - 1) + coeficiente_binomial(n - 1, k)

def main():
    n = int(input("Introduce el valor de n: "))
    k = int(input("Introduce el valor de k: "))
    print(coeficiente_binomial(n, k))

if __name__ == '__main__':
    main()