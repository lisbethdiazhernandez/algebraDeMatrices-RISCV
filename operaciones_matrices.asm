 .global programa

.data
    matriz1: .space 1000
    matriz2: .space 1000
    matriz3: .space 1000
    matriz4: .space 1000
    matriz5: .space 1000
    matriz6: .space 1000
    matriz7: .space 1000
    matriz8: .space 1000
    matriz9: .space 1000
 
    matriz1_dimensiones:
        .word 0,0
    matriz2_dimensiones:
    	.word 0,0
    matriz3_dimensiones:
    	.string "??"
    matriz4_dimensiones:
    	.string "??"
    matriz5_dimensiones:
    	.string "??"
    matriz6_dimensiones:
    	.string "??"
    matriz7_dimensiones:
    	.string "??"
    matriz8_dimensiones:
    	.string "??"
    matriz9_dimensiones:
    	.string "??"
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
    contador_matrices:
        .word 0
    contador_filas:
        .word 0   
    contador_columnas:
        .word 0   
    
.text



programa:

#------------------------------------------------------------ MACROS ------------------------------------------------

#--------------------------------------------almacenar_dimensiones_matriz------------------------------------

.macro almacenar_dimensiones_matriz(%numero_matriz, %numero_filas, %numero_columnas) # .macro name (%params, %param1)
	beqz %numero_matriz, matriz1 # if numero_matriz ==0 
	li t0, 1
	beq %numero_matriz, t0, matriz2 # if numero_matriz == 1
		
	matriz1:
		la a0, matriz1_dimensiones # Cargar matriz1_dimensiones a a0
		mv t0, %numero_filas	   # Cargar numero filas a t0
		sw t0, 0(a0)               # Almacenar t0 en a0[0]
		mv t0, %numero_columnas    # Cargar numero columnas a t0
		sw t0, 4(a0)               # Almacenar t0 en a0[4]
	j end_macro
	matriz2:
		la a0, matriz2_dimensiones # Cargar matriz1_dimensiones a a0
		mv t0, %numero_filas	   # Cargar numero filas a t0
		sw t0, 0(a0)               # Almacenar t0 en a0[0]
		mv t0, %numero_columnas    # Cargar numero columnas a t0
		sw t0, 4(a0)               # Almacenar t0 en a0[4]
	j end_macro
       		 
	end_macro: 
	.end_macro
#------------------------------------------end_almacenar_dimensiones_matriz------------------------------------	  
#------------ END MACROS ----------------
    la a0, msg_input_nummatrices # Imprimir mensaje inicial al usuario
    li a7, 4
    ecall
    
    li a7, 5 # Leer el número de la cantidad de matrices
    ecall
    mv t0, a0 # t0 guarda la cantidad de matrices
    
    # Inicializar el contador de matrices
    li t1, 0            # t1 es el contador
    
    # Bucle para leer filas y columnas de cada matriz
    bucle_matrices:
	bge t1, t0, mostrar_detalle    # Si t1 == t0, ir a mostrar detalles
    
    	la a0, msg_matriz_num
    	li a7, 4
    	ecall

    	mv a0, t1 # Imprimir número de la matriz
    	li a7, 1
    	ecall
    
    	la a0, msg_input_numfilas # Imprimir mensaje de número de filas
    	li a7, 4
    	ecall
    
    	li a7, 5 # Leer número de filas
    	ecall
    	mv t2, a0 # t2 guarda el número de filas
    
    	la a0, msg_input_numcolumnas # Imprimir mensaje de número de columnas
    	li a7, 4
    	ecall
    	
    	li a7, 5 # Leer número de columnas
    	ecall
    	mv t3, a0 # t3 guarda el número de columnas
    
    	# Almacenar las dimensiones en matriz_dim
    	slli t4, t1, 3
    	la t5, matriz_dim
    	add t5, t5, t4  
    	sw t2, 0(t5)    # Guarda el número de filas
    	sw t3, 4(t5)    # Guarda el número de columnas
    
  
        almacenar_dimensiones_matriz(t1, t2, t3) #Almacenar dimensiones el macro recibe (%numero_matriz, %numero_filas, %numero_columnas
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

            	 
		
            	addi t4, t4, 1 # Incrementar contador de columnas
            	j bucle_columnas

        
	        fin_bucle_columnas:
	            	addi t6, t6, 1 # incremental el contador de filas
	            	j lea_filas
        
    	fin_lea_filas:
            	addi t1, t1, 1 # Incrementar el contador de matrices
            	j bucle_matrices

#----------------------------- MACRO imprimir_dimensiones_matriz --------------------------
	.macro imprimir_dimensiones_matriz (%numero_matriz)
   		beqz %numero_matriz, matriz1

   		matriz1:
   			la a0, matriz1_dimensiones
       			lw t0, 0(a0)
       			mv a0, t0
       			li a7, 1
       			ecall
       			la a0, matriz1_dimensiones
       			lw t0, 4(a0)
       			mv a0, t0
       			li a7, 1
       			ecall
       			j end_macro
			

   		end_macro:
		.end_macro
#----------------------------- END MACRO imprimir_dimensiones_matriz --------------------------
mostrar_detalle:
    la a0, msg_detalle_matrices # Imprimir mensaje de detalle
    li a7, 4
    ecall
    li t1, 0
    imprimir_dimensiones_matriz(t1)

    li t1, 0 # Inicializar contador de matrices
     
finalizar:
    li a7, 10
    ecall

