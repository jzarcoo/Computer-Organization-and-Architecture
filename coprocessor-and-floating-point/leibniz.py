def leibniz(m):
    resultado = 0
    for i in range (m):
        numerador = (-1) ** i
        division = numerador / (2*i + 1)
        resultado += division
    return resultado * 4

m = int(input("Pon el valor de m: "))
pi = leibniz(m)
print(pi)
