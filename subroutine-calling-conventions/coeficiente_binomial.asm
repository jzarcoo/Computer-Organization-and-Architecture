# Calcula recursivamente el coeficiente binomial de $n$ en $k$ utilizando la identidad de Pascal $\binom{n}{k} = \binom{n-1}{k-1} + \binom{n-1}{k}$
.data
	pregunta_n: .asciiz "Introduce el valor de n: "
	pregunta_k: .asciiz "Introduce el valor de k: "
	resultado: .asciiz "El coeficiente binomial de n en k es: "
	error_k: .asciiz "Error: k debe ser positivo."
	error_n: .asciiz "Error: n debe ser positivo."

.text
.globl main

main:
	# Leer n
	li $v0 4       # imprimir pregunta
	la $a0 pregunta_n
	syscall
	li $v0 5             # Leer entero
	syscall
	move $t0 $v0         # Guardar n en $a0
    
    
    # Leer k
	li $v0 4     #imprimir pregunta
	la $a0 pregunta_k
	syscall
	li $v0 5             # Leer entero
	syscall
    move $t1 $v0         # Guardar k en $a1
    

	# Verificar que k no sea menor que 0
	bltz $t1 k_menor_cero
	# Verificar que n no sea menor que 0
	bltz $t0 n_menor_cero

	# Llamar a la subrutina coeficiente con parametros n y k
	move $a0 $t0
	move $a1 $t1
	jal coeficiente
	
	# Imprimir el resultado
	li $v0 4  
	la $a0 resultado
	syscall
	li $v0 1
	move $a0, $v1         # Mover resultado de v1 a a0 para imprimir
	syscall
	j fin

k_menor_cero:
	# Imprimir mensaje de error para k
	li $v0, 4
	la $a0, error_k
	syscall
	j fin

n_menor_cero:
	# Imprimir mensaje de error para n
	li $v0, 4
	la $a0, error_n
	syscall
	j fin

fin:
	# Salir del programa
	li $v0, 10
	syscall

# Subrutina coeficiente 
# Parametros: $a0 = n, $a1 = k
# return:  $v1 = coeficiente binomial n en k

coeficiente:
	sub $sp, $sp, 16    # creamos cuatro espacions vacios
	sw $ra, 0($sp)        # #primer espacio: dirección de retorn
	sw $a0, 4($sp)        # argumento $a0 (n)
	sw $a1, 8($sp)        # argumento $a1 (k)
	sw $s0, 12($sp)       # preservados tras las llamada


	# Caso base: si k es 0 o n ==  k se regresa 1
	beqz $a1, res_1     
	beq  $a0, $a1, res_1  

	# Caso base: si k > n se regresa 0
	bgt $a1, $a0, res_0  

	# Recursión - coeficiente(n-1, k-1)
	# Modificar parametros
	sub $a0, $a0, 1 #n-1
	sub $a1, $a1, 1  # k-1
	jal coeficiente
	move $s0, $v1         # Guardar resultado de llamada en $s0

	# Recursión -  coeficiente(n-1, k)
	# Restaurar parametros
	lw $a0 4($sp)      
	lw $a1 8($sp)        
	# Modificar paramtros
	sub $a0 $a0, 1 # n-1
	jal coeficiente

	# Sumar los resultados de ambas llamadas
	add $v1 $v1 $s0    

regreso:
	# Restaurar los registros
	lw $s0 12($sp)
	lw $a1 8($sp)
	lw $a0 4($sp)
	lw $ra 0($sp)
	addi $sp $sp, 16
	jr $ra               

res_1:
	# resultado en este caso base es 1
	li $v1 1            
	j regreso

res_0:
	# resultado de este caso base es 0
	li $v1 0              
	j regreso
