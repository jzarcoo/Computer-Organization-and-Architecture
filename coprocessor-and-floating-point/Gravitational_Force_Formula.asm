# Programa que calcula la Fuerza Gravitacional entre la Luna y la Tierra, usando números de precisión doble.
.data
	G: .double 6.674e-11
	m1: .double 5.9722e24
	m2: .double 7.346e22  
	r: .double 3.844e8
	msg:.asciiz "La fuerza gravitacional entre la Luna y la Tierra es:"
.text
.globl main

main:
	#cargar los valores a registros
	l.d $f0 G # G en f0
	l.d $f2 m1 # m1 en $f2
	l.d $f4 m2 # m2 en f4
	l.d $f6 r # r en f6
	mul.d $f6 $f6 $f6 # r cuadrada en f6
	

	mul.d $f8 $f2 $f4 # f8 = m1 * m2
	
	div.d $f8 $f8 $f6 #f8 = (m1 ¨*m2)/r2
	
	mul.d $f12 $f0 $f8 # f12 = g *   (m1 ¨*m2)/r2
	 
	 #imprimir 
	li $v0 4
    	la $a0 msg
    	syscall
    	
	li $v0 3    #imprimir doble       
    	syscall
	      

fin:
	#finalizar el programa
	li $v0 10
	syscall
	
