# La serie presentada es la serie de Leibniz y está serie tiende a PI
.data
	# Mensaje para pedir número
	msj_pide: .asciiz "\n Pon el valor de m: "
	# Almacenar el resultado
	resultado: .float 0
	# Constante cuatro 4
	cuatro: .float 4
	
.text
.globl main

main:
	# Pide número
	li $v0 4 # opcode: imprime string
	la $a0 msj_pide # mensaje a imprimir
	syscall
	
	# Lee número  del usuario
	li $v0 5 # opcode
	syscall
	
	# Guarda el número ingresado por el usuario en $t1
	move $t1 $v0 # $t1 = $v0 (m = $v0)
	
	# Guarda variable i para el loop
	li $t2 0 # i = 0
	
	# Guarda variable para el resultado
	l.s $f2 resultado
	
	# Guarda constante cuatro 4
	l.s $f10 cuatro
	
	# Calcula serie
	j leibniz
	
# Calcula la serie
# $t1 es m
# $t2 es i
# $t3 es el numerador ($f4)
# $t4 es el denominador ($f6)
# $f8 es la division
leibniz:
	beq $t2 $t1 multiplicacion # Si i == m termina el programa
	
	# Numerador: (-1)^i
	and $t3 $t2 1 # $t3 = 0 si $t2 es par, $t3 = 1 si $t2 es impar
	beq $t3 $zero par
	li $t3 -1 # Si $t2 es impar, entonces el numerador = -1
	j continuacion_loop
	
# Asigna el valor del numerador
par:
	li $t3 1 # Si $t2 es par, entonces el numerador = 1
	j continuacion_loop

# Continuación después de asignar el numerador	
continuacion_loop:
	# Denominador: 2*i + 1
	move $t4 $t2 # $t4 = $t2 (denominador = i)
	sll $t4 $t4 1 # recorrimiento a la izquierda (denominador = 2*i)
	add $t4 $t4 1 # $t4 += 1 (denominador = 2*i + 1)
	
	# Numerador a float
	mtc1 $t3 $f4 # Mover el entero $t3 a $f2 (registro de punto flotante)
	cvt.s.w $f4 $f4 # Convertir $f2 a float en $f2		
	# Denominador a float
	mtc1 $t4 $f6 # Mover el entero $t4 a $f4 (registro de punto flotante)
	cvt.s.w $f6 $f6 # Convertir $f2 a float en $f2
	
	# Division: numerador / denominador
	div.s $f8 $f4 $f6 
	
	# Suma a resulado
	add.s $f2 $f2 $f8 # $f2 += $f8
	
	# Loop
	add $t2 $t2 1 # $t2 += 1
	j leibniz
	
# Multiplica el resultado por 4
# $f10 es la constante 4
# $f2 es el resultado
multiplicacion:
	mul.s $f2 $f2 $f10 # $f2 *= $f10
	j pi
	
# Imprime el resultado
pi:
	li $v0 2 # opcode: imprime float
	mov.s $f12 $f2 # mueve $f2 en $f12 para imprimir
	syscall
	j fin
	
# Salir del programa
fin:
	li $v0 10 # opcode: terminar programa
	syscall
