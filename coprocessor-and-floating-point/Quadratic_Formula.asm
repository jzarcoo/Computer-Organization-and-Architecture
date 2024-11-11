# Usando la Formula General Cuadrática (Chicharronera), calcula el resultado de una ecuación cuadrática 
# cualquiera. Debe recibir 3 números de precisión doble del usuario usando Syscall (a, b y c) y 
# realizar las operaciones necesarias para obtener el resultado de la ecuación. Si la ecuación no tiene 
# respuesta imprimir un mensaje de error.
.data
	# Mensaje para pedir número a
	msj_pide_a: .asciiz "\n Pon el valor de (a): "
	# Mensaje para pedir número b
	msj_pide_b: .asciiz "\n Pon el valor de (b): "
	# Mensaje para pedir número c
	msj_pide_c: .asciiz "\n Pon el valor de (c): "
	# Constante 0
	CERO: .double 0
	# Constante 2
	DOS: .double 2
	# Constante 4
	CUATRO: .double 4
	# Error denominador cero
	msj_error_cero: .asciiz "\n No se puede dividir entre 0."
	# Error discriminante negativo
	msj_error_discriminante_negativo: .asciiz "\n No hay soluciones reales."
	# Respuesta x
	msj_res_x: .asciiz "\n X: "
	# Respuesta x1
	msj_res_x1: .asciiz "\n X1: "
	# Respuesta x2
	msj_res_x2: .asciiz "\n X2: "
	
.text
.globl main

# A: $f2
# B: $f4
# C: $f6
# DOS: $f8
# CUATRO: $f10
# CERO: $f16
main:
	# Pide numeros 
	# -------------------------------------------------------------------------------------
	
	# Pide numero A
	li $v0 4 # opcode: imprime string
	la $a0 msj_pide_a # mensaje a imprimir
	syscall
	# Lee número A
	li $v0 7 # opcode: lee double
	syscall
	# Guarda el número A ingresado por el usuario en $f2
	mov.d $f2 $f0 # $f2 = $f0
	
	# Pide numero B
	li $v0 4 # opcode: imprime string
	la $a0 msj_pide_b # mensaje a imprimir
	syscall
	# Lee número B
	li $v0 7 # opcode: lee double
	syscall
	# Guarda el número B ingresado por el usuario en $f4
	mov.d $f4 $f0 # $f4 = $f0
	
	# Pide numero C
	li $v0 4 # opcode: imprime string
	la $a0 msj_pide_c # mensaje a imprimir
	syscall
	# Lee número C
	li $v0 7 # opcode: lee double
	syscall
	# Guarda el número C ingresado por el usuario en $f6
	mov.d $f6 $f0 # $f6 = $f0
	
	# Carga constantes
	# -------------------------------------------------------------------------------------
	l.d $f8 DOS # constante dos 
	l.d $f10 CUATRO #constante cuatro
	l.d $f16 CERO # constante cero
	
	j formula

# denominador: $f14
# discriminante $f18, luego lo uso como raiz: $f18
# 	- auxiliar $f20
# numerador1: $f22, luego respuesta x1: $f22
# numerador2: $f24, luego respuesta x2: $f24
formula:
	# Denominador: a*2
	mul.d $f14 $f8 $f2
	
	# Revisa si el denominador es cero
	c.eq.d $f14 $f16 # $f14 == $f16
	bc1t error_cero
	
	# Discriminante: b^2 -4ac
	mul.d $f18 $f4 $f4 # b^2
	mul.d $f20 $f2 $f6 # ac
	mul.d $f20 $f10 $f20 # 4ac
	sub.d $f18 $f18 $f20 # b^2 -4ac
	
	# Revisa si el discriminante es menor a cero
	c.lt.d $f18 $f16 # discriminante < 0
	bc1t error_discriminante_negativo
	
	# Raiz: $f18
	sqrt.d $f18 $f18 # raiz de $f18
	
	# -b 
	neg.d $f4 $f4
	
	# Numerador 1: -b + raiz
	add.d $f22 $f4 $f18
	# Numerador 4: -b - raiz
	sub.d $f24 $f4 $f18
	
	# Respuesta x1
	div.d $f22 $f22 $f14
	# Respuesta x2
	div.d $f24 $f24 $f14
	
	# Unica solución
	c.eq.d $f22 $f24 # $f22 == $f24
	bc1t son_iguales 
	
	j dos_soluciones

# ERROR: División entre cero	
error_cero:
	li $v0 4 # opcode: imprime string
	la $a0 msj_error_cero # mensaje a imprimir
	syscall

	j fin
	
# ERROR: Discriminante negativo
error_discriminante_negativo:
	li $v0 4 # opcode: imprime string
	la $a0 msj_error_discriminante_negativo # mensaje a imprimir
	syscall

	j fin
	
# Imprime unica solución
son_iguales:
	# Imprime cadena
	li $v0 4 # opcode: imprime string
	la $a0 msj_res_x # mensaje a imprimir
	syscall
	
	# Imprime resultado
	li $v0 3 # opcode: imprime double
	mov.d $f12 $f22 # $f12 = $f22
	syscall
	
	j fin
	
# Imprime dos soluciones
# respuesa x1: $f22
# respuesta x2: $f24
dos_soluciones:
	# Imprime cadena x1
	li $v0 4 # opcode: imprime string
	la $a0 msj_res_x1 # mensaje a imprimir
	syscall
	
	# Imprime resultado x1
	li $v0 3 # opcode: imprime double
	mov.d $f12 $f22 # $f12 = $f22
	syscall
	
	# Imprime cadena x2
	li $v0 4 # opcode: imprime string
	la $a0 msj_res_x2 # mensaje a imprimir
	syscall
	
	# Imprime resultado x2
	li $v0 3 # opcode: imprime double
	mov.d $f12 $f24 # $f12 = $f24
	syscall
	
	j fin
	
# Salir del programa
fin:
	li $v0 10 # opcode: terminar programa
	syscall
