# Escribe un programa que, realice la sustracción de 2 numeros y la guarde
# en un registro temporal, despues:
# - Si el resultado es positivo, imprimir el resultado.
# - Si el resultado es negativo, imprimir un mensaje de error y limpiar
#   el espacio en memoria usado por el resultado.

.data 
	msg: .asciiz "Ingrese un numero A: "
	msg1: .asciiz "Ingrese un numero B: "
	msg_error: .asciiz "Error: El resultado fue negativo"
	
.text

.globl main

main:

	# Pedir que ingrese un numero A
	# Imprime mensaje
	li $v0 4 # código de imprimir string
	la $a0 msg
	syscall 
	# Lee entero
	li $v0 5 # código de read_int
	syscall
	# Guardar el numero en $t0
	move $t0 $v0
	
	# Pedir que ingrese un numero B
	# Imprime mensaje
	li $v0 4 # código de imprimir string
	la $a0 msg1
	syscall 
	# Lee entero
	li $v0 5 # codigo de read_int
	syscall
	# Guardar el numero en $t1
	move $t1 $v0
	
	# Substracción de $t0 y $t1 
	sub $t3 $t0 $t1 # $t3 = $t0 - $t1
	
	# Ver si es positivo
	bgez $t3 positivo # Si $t3 es mayor o igual a $zero salta a la etiqueta positivo
	j negativo	
	
positivo: 
	# Imprime el resultado
	li $v0 1 # código para imprimir int
	move $a0 $t3 # mueve el resultado a $a0
	syscall	
	j fin # termina el programa

negativo: 
	# Imprime mensaje de error
	li $v0 4  # código impimir string
	la $a0 msg_error # carga mensaje de error
	syscall
	
	# Limpia el espacio en memoria
	li $t3 0
	j fin # termina el programa
fin: 	
	# Terminar el programa
	li $v0 10
	syscall
	
