# Escribe un programa que, dado un numero tomado por la llamada a sistema 5, read int, 
# imprima n veces un mensaje cualquiera.

.data 
	msg: .asciiz "Ingrese un numero: "
	msg1: .asciiz "Un mensaje cualquiera \n"
	
.text

.globl main

main:

	# Pedir que ingrese un numero 
	li $v0 4 # código de imprimir string
	la $a0 msg
	syscall 
	
	# Pedir que lea de la entrada
	li $v0 5 # Código de read_int
	syscall
	# Guardar el numero en $t0
	move $t0 $v0
	
	# Imprimir n veces el mensaje: msg1
	li $v0 4 # código de imprimir string
	la $a0 msg1 # cargar el mensaje a imprimir

loop: 
	# for loop común: vamos a ir restando del n al 0 hasta que el registro sea 0
	beqz $t0 fin # Si $t0 == $zero salta a etiqueta din
	syscall  # Imprimir el mensaje
	sub $t0 $t0 1 #$t0 = $t0 - 1
	j loop # Salto incondicional a etiqueta loop

fin: 
	# Terminar el programa
	li $v0 10
	syscall
	
	
