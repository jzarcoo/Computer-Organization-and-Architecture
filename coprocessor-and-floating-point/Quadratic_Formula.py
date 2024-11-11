import math

def main():
    a = float(input("Pon el valor de a: "))
    b = float(input("Pon el valor de b: "))
    c = float(input("Pon el valor de c: "))

    denominador = a * 2

    if denominador == 0:
        print("No se puede dividir entre 0.")
        return

    discriminante = b**2 - 4*a*c
    if discriminante < 0:
        print("No hay soluciones reales.")
        return
    
    raiz = math.sqrt(discriminante)
    numerador1 = -b + raiz
    numerador2 = -b - raiz

    x1 = numerador1 / denominador
    x2 = numerador2 / denominador

    if x1 == x2:
        print("X: ", x1)
        return

    print("X1: ", x1)
    print("X2: ", x2)


if __name__ == "__main__":
    main()
    
