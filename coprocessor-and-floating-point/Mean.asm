# Calcula el promedio de 5 números flotantes.
.data 
	solicitud: .asciiz  "Ingresa un número: "
	res : .asciiz "El promedio es: "
	vi : .float 0.0
	divisor: .float 5.0
	
.text 
.globl main

 main: 
 	# iniciar variable en 5
 	li $t1 5 # contara el numero de ingresos
 	l.s $f2 vi # acumula la suma
 	
 	

 loop:
 	#verificar si ya van los 5 numeros
 	beqz $t1 calc_prom
 	
 	# imprimir mensaje para qe ingrese el numero
 	li $v0 4
 	la $a0 solicitud
 	syscall
 	
 	#recibir el flotante (queda en f0)
 	li $v0 6
 	syscall 
 	
 	#sumarlo en suma
 	add.s $f2 $f2 $f0
 	#disminuir en uno la variable
 	subi  $t1 $t1 1
 	j loop
 	
 calc_prom:
 
 	l.s $f4 divisor #entre 5
 	div.s $f12  $f2 $f4 #f2 tiene la suma y lo dividimos entre 5($f4) y se guarda en $f12
 	
 	#impimir resultado
 	li $v0 4
    	la $a0 res
    	syscall
    	
    	#imprimir el valor
    	li $v0 2           
    	syscall
 	
fin:
	#finalizar el programa
	li $v0 10
	syscall
