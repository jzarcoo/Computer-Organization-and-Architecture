# Algoritmo Quine-McCluskey
# Zarco Romero José Antonio & Flores Morán Julieta Melina

# Importamos copy para hacer copias profundas de diccionarios
import copy

def a_binario(termino, maximo):
    """
        Convierte un número decimal a su representación binaria, rellenando con ceros a la izquierda según el número más grande.
        Ejemplo a_binario(3,15) = "000000000000011"

        Args:
            termino (int): El número a convertir.
            maximo (int): El número más grande que se puede representar con la misma cantidad de bits.

        Returns:
            str: La representación binaria del número.
    """
    return bin(int(termino))[2:].zfill(maximo)

def peso_hamming(termino):
    """
        Calcula el peso de Hamming (número de bits 1) de un término binario.

        Args:
            termino (str): El termino binario.

        Returns:
            int: El peso de Hamming.
    """
    return termino.count("1")

def numero_bits_diferentes(a, b):
    """
        Calcula la cantidad de bits diferentes entre dos terminos binarios.

        Args:
            a (str): El primer termino binario.
            b (str): El segundo termino binario.

        Returns:
            int: La cantidad de bits diferentes.
    """
    return sum(el1 != el2 for el1, el2 in zip(a, b))

def agrupar_pesos(terminos):
    """
        Agrupa los términos según su peso de Hamming.

        Args:
            terminos (list): Una lista de terminos binarios.

        Returns:
            dict: Un diccionario con los pesos de Hamming de cada termino.
    """
    pesos = {}
    for tupla in terminos:
        peso = peso_hamming(tupla[0])
        if peso not in pesos:
            pesos[peso] = []
        pesos[peso].append(tupla)
    return pesos
    

def terminos_a_binario(terminos):
    """
        Convierte una lista de números decimales a sus representaciones binarias.

        Args:
            terminos (list): Una lista de números decimales.

        Returns:
            list: Una lista de terminos binarios.
    """
    try:
        terminos = [int(t) for t in terminos]
    except ValueError:
        print("Los minterminos deben ser números enteros.")
        exit(1)
    maximo = max(terminos)
    maximo = len(bin(maximo)) - 2  

    for i in range(len(terminos)):
        terminos[i] = (a_binario(terminos[i], maximo), set([terminos[i]]))
    return terminos
                    
def get_terminos():
    """
        Pide al usuario que ingrese los minterminos separados por comas.

        Returns:
            list: Una lista de terminos.
    """
    terminos = input("Ingresa los minterminos: ")
    if "," in terminos:
        terminos = terminos.split(",")
    else:
        terminos = terminos.split()
    terminos = [t.strip() for t in terminos] 
    return terminos

def empata_bits(b1, b2):
    """
        Compara dos bits y devuelve un guión si son diferentes o el mismo si son iguales.

        Args:
            b1 (str): El primer bit.
            b2 (str): El segundo bit.

        Returns:
            str: Un guion si los bits son diferentes o el mismo si son iguales.
    """
    if b1 == b2:
        return b1
    else:
        return "-"
    
def empatar_terminos(t1,t2):
    """
        Empata dos terminos binarios. Empata cada bit y combina los mintérminos que abarcan los mismos

        Args:
            t1 (tuple): Un termino binario.
            t2 (tuple): Un termino binario.

        Returns:
            tuple: Un nuevo termino binario empatado.
    """
    cadena = ''.join(empata_bits(b1, b2) for b1, b2 in zip(t1[0], t2[0]))
    conjunto1 = t1[1]
    conjunto2 = t2[1]
    return (cadena, conjunto1.union(conjunto2))

def get_nivel_superior(diccionario, nivel_anterior):
    """
        Obtiene el nivel superior de un diccionario, es decir, el que tiene un peso de Hamming mayor.

        Args:
            diccionario (dict): Un diccionario de pesos de Hamming.
            nivel_anterior (int): El nivel anterior.

        Returns:
            list: Una lista de terminos binarios con un peso de Hamming mayor.
    """
    superior = nivel_anterior + 1;
    if superior in diccionario:
        return diccionario[superior]
    else:
        return []
    
def unir_diccionarios(diccionario1, diccionario2):
    """
        Une dos diccionarios de terminos binarios.

        Args:
            diccionario1 (dict): Un diccionario de terminos binarios.
            diccionario2 (dict): Un diccionario de terminos binarios.

        Returns:
            dict: El diccionario2 unido con el diccionario1.
    """
    for llave in diccionario1.keys():
        if llave in diccionario2:
            diccionario2[llave]+=diccionario1[llave]
        else:
            diccionario2[llave] = diccionario1[llave]
    return diccionario2

def algoritmo(diccionario):
    """
        Realiza la reducción de Quine-McCluskey de un diccionario de terminos binarios.

        Args:
            diccionario (dict): Un diccionario de terminos binarios, agrupados por peso de Hamming.

        Returns:
            dict: El diccionario de terminos binarios reducido, con llaves de pesos de Hamming.
    """
    while True:
        sin_empatar = copy.deepcopy(diccionario)
        patrones = {}
        pesos = sorted(diccionario.keys())
        for peso in range(len(pesos)):
            if peso not in pesos:
                continue
            for termino in diccionario[peso]:
                for termino2 in get_nivel_superior(diccionario, peso):
                    if numero_bits_diferentes(termino[0], termino2[0]) == 1:
                        empate = empatar_terminos(termino, termino2)
                        nuevo_peso = peso_hamming(empate[0])
                        if nuevo_peso not in patrones:
                            patrones[nuevo_peso] = [empate]
                        else:
                            patrones[nuevo_peso].append(empate)
                        try:
                            sin_empatar[peso].remove(termino)
                            sin_empatar[peso+1].remove(termino2)
                        except ValueError:
                            pass
        if len(patrones) == 0:
            break
        diccionario = unir_diccionarios(patrones, sin_empatar)
    return diccionario

def resultado_filtrado(diccionario):
    """
        Filtra los términos repetidos de un diccionario.

        Args:
            diccionario (dict): Un diccionario de terminos binarios.

        Returns:
            list: Una lista de términos binarios sin terminos repetidos.
    """
    lista_tuplas = []
    for value in diccionario.values():
        for tupla in value:
            if tupla not in lista_tuplas:
                lista_tuplas.append(tupla)
    # lista_tuplas.sort(key=lambda tupla: len(tupla[1]), reverse=True)
    return lista_tuplas

def crear_diccionario_minterminos(lista_tuplas):
    """
        Crea un diccionario de terminos binarios, donde la llave es el mintermino y el valor son todos los patrones que lo generan.

        Args:
            lista_tuplas (list): Una lista de tuplas de terminos binarios.

        Returns:
            dict: Un diccionario de terminos binarios con llaves de minterminos y valores de patrones.
    """
    diccionario_minterminos = {}
    for tupla in lista_tuplas:
        for min in tupla[1]:
            if min not in diccionario_minterminos:
                diccionario_minterminos[min] = [tupla]
            else:
                diccionario_minterminos[min].append(tupla)
    return diccionario_minterminos

def sacar_esenciales(diccionario_minterminos):
    """
        Selecciona los patrones con las expresiones de la función reducida.

        Args:
            diccionario_minterminos (dict): Un diccionario de terminos binarios con llaves de minterminos y valores de patrones.

        Returns:
            set: Los patrones con las expresiones de la función reducida.
    """
    # Recibo un diccionario de la forma mintermino: [("patron", {min, min}), ()]
    # Todos los minterminos que aun no son generados por esenciales
    faltan = set(diccionario_minterminos.keys())
    esenciales = [] # guarda las tuplas esenciales
    entregables = set() # guarda los patrones que se muestran

    # Los que solo son generados por un patron se agregan primero a esenciales
    for key, value in diccionario_minterminos.items():
        if len(value) == 1:
            patron = value[0] # tupla del único patron
            esenciales.append(patron) 
            entregables.add(patron[0]) # se agrega el patron a los entregables
            faltan.difference_update(patron[1]) # quitar de los que faltan el conjunto de los que ya se cubrieron

    # Cubrimos todos los que faltan
    for mintermino in faltan.copy(): # los que faltan 
        if mintermino not in faltan: # si ya se cubrio
            continue
        patrones = diccionario_minterminos[mintermino] 
        patrones.sort(key=lambda tupla: len(tupla[1]), reverse=True)  # ordenamos los patrones segun la longitud del set, desde el mas grande para qe abarque más minterminos
        patron = patrones[0] #Elegimos el patron que toma mas tuplas
        esenciales.append(patron) # este patron se vuelve esencial 
        entregables.add(patron[0])  # se agrega la cadena a los entregables
        faltan.difference_update(patron[1]) # borramos todos los minterminos que se usaron en este patron de faltan

    return entregables

def seleccionar_minterminos_esenciales(diccionario):
    """
        Selecciona los patrones con las expresiones de la función reducida.

        Args:
            diccionario (dict): Un diccionario de terminos binarios.

        Returns:
            set: Los patrones con las expresiones de la función reducida.
    """
    # Recibo un diccionario con la estructura: peso: [("1010", {minterminos}), ()]
    # es decir, una lista de tuplas de la forma patron, minterminos que lo generan
    # quiero crear un nuevo diccionario que tenga de llaves los minterminos y listas de los minterminos que generan esa clave
    lista_tuplas = resultado_filtrado(diccionario)
    diccionario_minterminos = crear_diccionario_minterminos(lista_tuplas)
    # Quiero eliminar redundancia
    esenciales = sacar_esenciales(diccionario_minterminos)
    return esenciales
        
def formato_minterminos(minterminos):
    """
        Formatea los minterminos en una cadena.

        Args:
            minterminos (set): Un conjunto de minterminos.

        Returns:
            str: Una cadena con los minterminos formateados.
    """
    # recibo un conjunto de cadenas {"1-10", }
    # desde x_0 hasta x_n
    cadena = ''
    for j, min in enumerate(minterminos):
        minN = ""
        for i,res in enumerate(min):
            letra = f"x_{i}"
            if res == '1':
                minN += f'({letra})'
            elif res == '0':
                minN += f'(¬{letra})'
        cadena += (minN + ' + ') if j < len(minterminos) - 1 else minN
    #se regresa una cadena donde todos los minterminos esten sumados
    return cadena


def quine_mccluskey(terminos):
    """
        Realiza la reducción de Quine-McCluskey de una lista de terminos.

        Args:
            terminos (list): Una lista de terminos.

        Returns:
            list: Una lista de terminos reducidos.
    """
    if terminos == []:
        return set()
    terminos = terminos_a_binario(terminos)
    pesos = agrupar_pesos(terminos)
    resultado = algoritmo(pesos)
    resultado = seleccionar_minterminos_esenciales(resultado)
    # print("Patrones generados")
    minterminos_formato = formato_minterminos(resultado)
    print("Reducción de Quine-McCluskey: ", minterminos_formato)
    return resultado

def main():
    """
        Funcion principal.
    """
    terminos = get_terminos()
    quine_mccluskey(terminos)

if __name__ == '__main__':
    """
        Punto de entrada del programa.
    """
    try:
        main()
    except EOFError: # Ctrl + D
        print('Bye')
    except KeyboardInterrupt: # Ctrl + C
        print('Bye')