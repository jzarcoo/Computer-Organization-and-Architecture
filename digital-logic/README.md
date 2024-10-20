# Algoritmo Quine-McCluskey

Por Zarco Romero José Antonio & Flores Morán Julieta Melina

- Lenguaje de programación: Python

El programa recibe como entrada los mintérminos de la función de conmutación e imprime el resultado de la reducción de Quine-McCluskey, en formato 
$x_i$ con $i \in \mathbb{N}$

Ejemplo de uso con ejercicio 1.3.5 recuperado del documento [Lógica digital y diseño de circuitos digitales](https://drive.google.com/file/d/1BdCwuwFcSar5W5nPxA98FVNfTxZfd6yg/view), página 19.

```sh
python3 Quine_McCluskey.py 

Ingresa los minterminos: 0,2,3,5,6,7
Reducción de Quine-McCluskey:  (¬x_0)(¬x_2) + (x_0)(x_2) + (x_1)
```

También, realizamos un script `Test_qm.py` para probar el programa con diferentes entradas.

```sh
python3 Test_qm.py 

Reducción de Quine-McCluskey:  (x_1)(¬x_2) + (¬x_1)(x_3) + (x_0)(x_1)
.Reducción de Quine-McCluskey:  (x_1) + (x_0)(x_2) + (¬x_0)(¬x_2)
.Reducción de Quine-McCluskey:  (¬x_0)(x_1)(¬x_2) + (x_2)(x_3) + (¬x_1)(x_3) + (x_0)(¬x_1)(x_2)
..Reducción de Quine-McCluskey:  (x_0)(¬x_1)(x_2) + (x_1)(x_3) + (¬x_0)(¬x_2)(x_3) + (x_0)(x_1)(¬x_2) + (¬x_0)(x_1)(x_2)
.
----------------------------------------------------------------------
Ran 5 tests in 0.001s

OK
```
