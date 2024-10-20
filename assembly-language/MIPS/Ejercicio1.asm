# Escribe un programa que, sin usar la memoria ni la instrucción move, 
# copie el contenido de un registro a otro.

.text

.globl main

main:
	# Sea $t1 el registro que se quiere mover y $t2 el destino 
	
	# Ponemos un valor en $t1
	li $t1 1
	
	# Podemos mover el valor del registro asignandole la suma del registro con 0
	add $t2  $t1 $zero # $t1 = $t0 + 0
	
	# Terminar el programa
	li  $v0 10
	syscall
	
	
	
