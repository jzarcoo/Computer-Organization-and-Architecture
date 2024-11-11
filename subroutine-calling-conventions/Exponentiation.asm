# El programa calcula $b^a$ (en este caso, $4^5=1024$) utilizando recursión y multiplicaciones sucesivas. En cada llamada a mist_1, se reduce el valor de $a$ y se multiplica el resultado acumulado por $b$ en cada iteración.
	.data
a:  	.word	5
b: 	.word 	4
	.text
	.globl main
main:  # Preambulo main
	lw	$a0, a 		# Guarda a en $a0
    	lw  	$a1, b		# Guarda b en $a1
    	# Invocacion de mist_1
    	jal 	mist_1		# jump and link
    	# Retorno de mist_1
    	move  	$a0, $v0    	# Cargar el resultado en $a0
    	li    	$v0, 1      	# Código para imprimir entero
    	syscall           	# Imprimir resultado
    	# Conclusion main
    	li    	$v0, 10     	# Termina el programa
    	syscall
# mist_1 recibe como argumentos $a0 y $a1
# Calcula b^a
mist_1:	# Preambulo mist_1
	addi  	$sp, $sp, -16	# Reserva espacio en memoria para el marco
    	sw    	$ra, 0($sp)  	# Guardar $ra
    	sw    	$a0, 4($sp)  	# Guardar $a0
    	sw    	$a1, 8($sp)  	# Guardar $a1
    
    	move  	$s0, $a0		# Guarda $a0 (a) en $s0
    	move  	$t0, $a1		# Guarda $a1 (b) en $t0
    	li    	$t1, 1		# Carga 1 en $t1
loop_1:	beqz  	$s0, end_1
	# Invocación de mist_0
	move  	$a0, $t0    	# Se pasa el argumento $a0
	move  	$a1, $t1    	# Se pasa el argumento $a1
	
	jal   mist_0		# jump and link
    	
    	# Retorno de mist_0
	move  	$t1, $v0    	# Guardar el resultado (multiplicación acumulada de b)
	subi  	$s0, $s0, 1	# $s0 (a) -= 1
    	j     loop_1		# Salta a loop_1
end_1:	# Conclusion mist_1
    	move	$v0, $t1		# Se retorna el resultado en $v0
    	
    	# Restaurar registros guardados
    	lw    	$a1, 8($sp)	# Recuperar el valor de $a1 de la pila
    	lw    	$a0, 4($sp)	# Recuperar el valor de $a0 de la pila
    	lw    	$ra, 0($sp)	# Recuperar el valor de $ra de la pila
    	addi  	$sp, $sp, 16	# Eliminar el marco
    	jr    	$ra		# Regresar el control a la rutina invocadora
# mist_0 recibe como argumentos $a0 y $a1
# $v0 = $a0 (b) * $a1 (multiplicación acumulada de b)
mist_0:
    	addi  	$sp, $sp, -16	# Reserva espacio en memoria para el marco
    	sw    	$ra, 0($sp)  	# Guardar $ra
    	sw    	$a0, 4($sp)  	# Guardar $a0
    	sw    	$a1, 8($sp)  	# Guardar $a1
    
    	mult  	$a0, $a1     	# Multiplicar $a0 y $a1
    	# Conclusion mist_0
    	# Move from LO register
    	mflo  	$v0          	# Guardar el resultado en $v0
    
    	# Restaurar registros guardados
    	lw    	$a1, 8($sp)	# Recuperar el valor de $a1 de la pila
    	lw    	$a0, 4($sp)	# Recuperar el valor de $a0 de la pila
    	lw    	$ra, 0($sp)	# Recuperar el valor de $ra de la pila
    	addi  	$sp, $sp, 16	# Eliminar el marco
    	jr    	$ra		# Regresar el control a la rutina invocadora
