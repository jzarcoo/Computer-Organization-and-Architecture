# Escribe un programa que calcule el cociente y el residuo de una division.
# No puedes utilizar la operacion div y debe imprimir el cociente y el residuo
# antes de terminar la ejecucion. El cociente debera guardarse en el registro
# $v0 y el residuo en $v1 y (Antes de sustituirlo por el codigo de salida del
# programa, claro esta)

.data 
	ing1: .asciiz "Ingrese el dividendo: "
	ing2: .asciiz "Ingrese el divisor: "
	msg_cociente: .asciiz "El cociente es: "
	msg_residuo: .asciiz "\nEl residuo es: "

.text
.globl main

main:
	# Pedir y guardar el dividendo
	# Imprimir mensaje
	li $v0 4 # imprimir string
	la $a0 ing1 # Cargar string
	syscall
	# Leer entero
	li $v0 5 # Código para leer entero
	syscall
	# Guarda el dividendo en t0
	move $t0 $v0 
	
	# Pedir y guardar el divisor
	# Imprimir mensaje
	li $v0 4 # imprimir string
	la $a0 ing2 # Cargar string
	syscall
	# Leer entero
	li $v0 5 
	syscall
	# Guardar el divisor en t1
	move $t1 $v0 
	
division:
	li $t2 0 # el cociente se guarda en t2
	move $v1 $t0 # copiamos el dividendo para irlo modificando y obtener el residuo
	j loop

loop:
	blt $v1 $t1 imprimir # si el residuo es más chico que el divisor acabamos
	
	# División
	sub $v1 $v1 $t1 # residuo = residuo - divisor
	addi $t2 $t2 1 # sumar uno al cociente
	j loop 
	
imprimir:
	# v1 es el residuo y t2 es el cociente
	# Imprimir el cociente
	li $v0 4 # imprimir strring
	la $a0 msg_cociente
	syscall
	li $v0 1 #imprimir entero
	move $a0 $t2
	syscall
	
	# Imprimir el residuo
	li $v0 4 # imprimir strring
	la $a0 msg_residuo
	syscall
	li $v0 1 #imprimir entero
	move $a0 $v1
	syscall
	
	# El residuo ya esta en $v1, guardamos el cociente en v0
	move $v0 $t2
	
	j fin

fin:
	# Termina el programa
	li $v0 10
	syscall
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
