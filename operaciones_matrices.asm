 .global programa

.data
    msg_input_nummatrices: 
        .string "Ingresa la cantidad de matrices a utilizar:\0"
    msg_input_numfilas: 
        .string "Ingresa el número de filas para la matriz \0"
    msg_input_numcolumnas: 
        .string "Ingresa el número de columnas para la matriz \0"
    msg_matriz_num: 
        .string "Matriz número: \0"
    msg_detalle_matrices: 
        .string "Detalle de matrices:\n\0"
    msg_input_celda:
        .string "Ingresa el valor para la celda [ \0"
    msg_coma:
        .string ", \0"
    msg_cerrar_corchete:
        .string "]: \0"
    matriz_dim: 
        .align 2
    matrices_valores:    # Reservar un espacio para almacenar los valores de las matrices
        .space 1024

    
.text

programa:
    # Imprimir mensaje inicial al usuario
    la a0, msg_input_nummatrices
    li a7, 4
    ecall

    # Leer el número de la cantidad de matrices
    li a7, 5
    ecall
    mv t0, a0           # t0 guarda la cantidad de matrices
    
    # Inicializar el contador de matrices
    li t1, 0            # t1 es el contador
    
    # Bucle para leer filas y columnas de cada matriz
    bucle_matrices:
	bge t1, t0, mostrar_detalle    # Si t1 == t0, mostrar detalles
    
    	la a0, msg_matriz_num
    	li a7, 4
    	ecall

    	# Imprimir número de la matriz
    	mv a0, t1
    	li a7, 1
    	ecall
    
    	# Imprimir mensaje de número de filas
    	la a0, msg_input_numfilas
    	li a7, 4
    	ecall
    
   	# Leer número de filas
    	li a7, 5
    	ecall
    	mv t2, a0       # t2 guarda el número de filas
    
    	# Imprimir mensaje de número de columnas
    	la a0, msg_input_numcolumnas
    	li a7, 4
    	ecall
    
    	# Leer número de columnas
    	li a7, 5
    	ecall
    	mv t3, a0       # t3 guarda el número de columnas
    
    	# Almacenar las dimensiones en matriz_dim
    	slli t4, t1, 3
    	la t5, matriz_dim
    	add t5, t5, t4  
    	sw t2, 0(t5)    # Guarda el número de filas
    	sw t3, 4(t5)    # Guarda el número de columnas

    	# Bucle para leer los valores de cada celda
    	li t6, 0  # Contador de filas
    	lea_filas:
		bge t6, t2, fin_lea_filas
    		li t4, 0
        bucle_columnas:
            	bge t4, t3, fin_bucle_columnas
            
            	# Imprimir mensaje solicitando valor de la celda
            	la a0, msg_input_celda
            	li a7, 4
            	ecall
            		
            	#Imprimir número de fila
 		        mv a0, t6
            	li a7, 1
            	ecall

            	# Imprimir coma
            	la a0, msg_coma
            	li a7, 4
            	ecall

            	# Imprimir número de columna
            	mv a0, t4
            	li a7, 1
            	ecall
            	
            	# Imprimir cierre de corchete
            	la a0, msg_cerrar_corchete
            	li a7, 4
            	ecall

            	# Leer valor de la celda
            	li a7, 5
    		    ecall

            	#Calcular dirección de memoria para almacenar el valor
            	mv t5, a0           # t5 almacena el valor de la celda
            	la a0, matrices_valores
            	slli a1, t3, 2
            	mul a1, t6, a1 
            	add a0, a0, a1
            	slli a1, t4, 2
            	add a0, a0, a1 
            	sw t1, 0(a0)
 
		#Incrementar contador de columnas
            	addi t4, t4, 1
            	j bucle_columnas

        
	        fin_bucle_columnas:
	            	addi t6, t6, 1
	            	j lea_filas
        
    	fin_lea_filas:
            	addi t1, t1, 1
            	j bucle_matrices

mostrar_detalle:
    # Imprimir mensaje de detalle
    la a0, msg_detalle_matrices
    li a7, 4
    ecall

    # Inicializar contador
    li t1, 0
     
finalizar:
    li a7, 10
    ecall



