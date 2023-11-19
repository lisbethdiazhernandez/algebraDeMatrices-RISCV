.global programa

.data
    matriz1: .space 400
    matriz_operacion1: .space 400
    matriz2: .space 400
    matriz_operacion2: .space 400
    matriz3: .space 400
    matriz4: .space 400
    matriz5: .space 400
    matriz6: .space 400
    matriz7: .space 400
    matriz8: .space 400
    matriz9: .space 400
    matriz_resultado: .space 400 
    matriz_escalar: .space 400 
    matriz1_dimensiones:
        .word 0,0
    matriz2_dimensiones:
    	.word 0,0
    matriz3_dimensiones:
    	.word 0,0
    matriz4_dimensiones:
    	.word 0,0
    matriz5_dimensiones:
    	.word 0,0
    matriz6_dimensiones:
    	.word 0,0
    matriz7_dimensiones:
    	.word 0,0
    matriz8_dimensiones:
    	.word 0,0
    matriz9_dimensiones:
    	.word 0,0
    matriztemp_dimensiones:
    	.word 0,0  
    matrizescalar_dimensiones:
    	.word 0,0   
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
    msg_abrir_corchete:
        .string "[ \0"
    msg_coma:
        .string ", \0"
    msg_cerrar_corchete:
        .string "]: \0"
    msg_nueva_linea:
    	.string "\n\0"
    msg_input_operacion:
        .string "Ingresa su operacion: "
    input_operacion: 
    	.space 100
    error_parentesis: 
    	.string "Sintaxis incorrecta, se encontro un (, pero no el de finalizacion."
    se_procedera_operacion: 
    	.string "Se procedera a operar: "
    
    cadena_a_operar: 
    	.space 100	

    contador_matrices:
        .word 0
        .align 2
    cantidad_matrices:
        .word 0
        .align 2
    contador_filas:
        .word 0   
    contador_columnas:
        .word 0   
    indice_parentesis:
        .word 0
    substring_buffer:
        .space 100
    indice_operador: 
    	.word 0     
.text



programa:

#------------------------------------------------------------ MACROS ------------------------------------------------
#--------------------------------------------almacenar_valores_matriz------------------------------------
.macro almacenar_valores_matriz(%numero_matriz, %indice_fila, %indice_columna, %valor)
    li t0, 0
    beq %numero_matriz, t0, usar_matriz1 # if numero_matriz == 0 ir a use_matriz1
    li t0, 1
    beq %numero_matriz, t0, usar_matriz2 # if numero_matriz == 1 ir a use_matriz2
    li t0, 2
    beq %numero_matriz, t0, usar_matriz3
    li t0, 3
    beq %numero_matriz, t0, usar_matriz4
    li t0, 10
    beq %numero_matriz, t0, usar_matriztemp
    li t0, 11
    beq %numero_matriz, t0, usar_matrizescalar
    j end_macro

    usar_matriz1:
        la a0, matriz1 # carga a a0 matriz1
        la t0, matriz1_dimensiones # cargar a t3 matriz1_dimensiones
        j calcular_mapeo # ir a calculate_address
    usar_matriz2:
        la a0, matriz2
        la t0, matriz2_dimensiones
        j calcular_mapeo
    usar_matriz3:
        la a0, matriz3
        la t0, matriz3_dimensiones
        j calcular_mapeo
    usar_matriz4:
        la a0, matriz4
        la t0, matriz4_dimensiones
	j calcular_mapeo
    usar_matriztemp:
     	la a0, matriz_resultado
     	la t0, matriztemp_dimensiones
    usar_matrizescalar:
    	la a0, matriz_escalar
    	la t0, matrizescalar_dimensiones
    calcular_mapeo: #Aca se realiza el calculo 
    	mv a1, t1
        lw t1, 0(t0) # obtener numero de columnas de t0[0]
        mv t0, %valor
        mul t5, %indice_fila, t1 # guardar en t5 = indice fila * numero de columnas
        add t5, t5, %indice_columna # sumar a t5 el indice de columna
        li t1, 4 # se carga a t1 4 (tamano de una palabra)
        mul t5, t5, t1 # t5 = t5 * 4
        add a0, a0, t5 # pos
        sw t0, 0(a0) # guardar valor
        mv t1, a1
        mv a1, a0

    end_macro:
    .end_macro


#--------------------------------------------almacenar_dimensiones_matriz------------------------------------

.macro almacenar_dimensiones_matriz(%numero_matriz, %numero_filas, %numero_columnas) # .macro name (%params, %param1)
	beqz %numero_matriz, matriz1 # if numero_matriz ==0 
	li t0, 1
	beq %numero_matriz, t0, matriz2 # if numero_matriz == 1
	li t0, 2
	beq %numero_matriz, t0, matriz3 # if numero_matriz == 2
	li t0, 10
	beq %numero_matriz, t0, matriztemp # if numero_matriz == 'a'
	li t0, 11
	beq %numero_matriz, t0, matrizescalar # if numero_matriz == 'a'
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
        matriz3:
		la a0, matriz3_dimensiones # Cargar matriz1_dimensiones a a0
		mv t0, %numero_filas	   # Cargar numero filas a t0
		sw t0, 0(a0)               # Almacenar t0 en a0[0]
		mv t0, %numero_columnas    # Cargar numero columnas a t0
		sw t0, 4(a0)               # Almacenar t0 en a0[4]
	j end_macro
	li t0, 3
	beq %numero_matriz, t0, matriz4 # if numero_matriz == 3
	matriz4:
		la a0, matriz4_dimensiones # Cargar matriz1_dimensiones a a0
		mv t0, %numero_filas	   # Cargar numero filas a t0
		sw t0, 0(a0)               # Almacenar t0 en a0[0]
		mv t0, %numero_columnas    # Cargar numero columnas a t0
		sw t0, 4(a0)               # Almacenar t0 en a0[4]
	j end_macro
	 
	matriztemp:
		la a0, matriztemp_dimensiones # Cargar matriztemp_dimensionesa0
		mv t0, %numero_filas	   # Cargar numero filas a t0
		sw t0, 0(a0)               # Almacenar t0 en a0[0]
		mv t0, %numero_columnas    # Cargar numero columnas a t0
		sw t0, 4(a0)               # Almacenar t0 en a0[4]
	j end_macro
	matrizescalar:
		la a0, matrizescalar_dimensiones # Cargar matriztemp_dimensionesa0
		mv t0, %numero_filas	   # Cargar numero filas a t0
		sw t0, 0(a0)               # Almacenar t0 en a0[0]
		mv t0, %numero_columnas    # Cargar numero columnas a t0
		sw t0, 4(a0) 
	end_macro: 
	.end_macro
#------------------------------------------end_almacenar_dimensiones_matriz------------------------------------	  
#------------------------------------------ END MACROS --------------------------------------------------------
    la a0, msg_input_nummatrices # Imprimir mensaje inicial al usuario
    li a7, 4
    ecall
    
    li a7, 5 # Leer el número de la cantidad de matrices
    ecall
    mv t0, a0 # t0 guarda la cantidad de matrices
    la t2, cantidad_matrices
    sw t0, 0(t2)
    
    # Inicializar el contador de matrices
    la t2, contador_matrices
    li t1, 0            # t1 es el contador
    sw t1, 0(t2)        # guardar el valor del contador

    bucle_matrices:
    	la t2, contador_matrices
    	lw t1, 0(t2)  #cargar el contador de matrices a t1

    	la t2, cantidad_matrices
    	lw t0, 0(t2) 
    	
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
    		mv t5, a0
    		 
    		almacenar_valores_matriz(t1, t6, t4, t5) #%numero_matriz, %indice_fila, %indice_columna, %valor
		
            	addi t4, t4, 1 # Incrementar contador de columnas
            	j bucle_columnas

        
	        fin_bucle_columnas:
	            	addi t6, t6, 1 # incremental el contador de filas
	            	j lea_filas
        
    	fin_lea_filas:
    		la t2, contador_matrices  # Cargar contador matrices a t2
    		lw t1, 0(t2)  # cargar el contador a t1
    		addi t1, t1, 1  # incrementar contador
    		sw t1, 0(t2)  # guardar de nuevo en contador_matrices nuevo valor 
    		j bucle_matrices

##################################### BEGIN MACROS ####################################
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
#----------------------------- MACRO imprimir_valores_matriz --------------------------
.macro imprimir_valores_matriz(%numero_matriz)
    li t0, 0
    beq %numero_matriz, t0, imprimir_matriz1
    li t0, 1
    beq %numero_matriz, t0, imprimir_matriz2
    li t0, 2
    beq %numero_matriz, t0, imprimir_matriz3
    li t0, 3
    beq %numero_matriz, t0, imprimir_matriz4
    
    li t0, 10
    beq %numero_matriz, t0, imprimir_matriztemp
    li t0, 11
    beq %numero_matriz, t0, imprimir_matrizescalar
    j end_macro
    imprimir_matriz1:
        la t1, matriz1
        la t2, matriz1_dimensiones
        j imprimir_matriz
    imprimir_matriz2:
        la t1, matriz2
        la t2, matriz2_dimensiones
        j imprimir_matriz
    imprimir_matriz3:
        la t1, matriz3
        la t2, matriz3_dimensiones
        j imprimir_matriz
    imprimir_matriz4:
        la t1, matriz4
        la t2, matriz4_dimensiones
        j imprimir_matriz
    imprimir_matriztemp:
        la t1, matriz_resultado
        la t2, matriztemp_dimensiones
        j imprimir_matriz
    imprimir_matrizescalar:
    	la t1, matriz_escalar
    	la t2, matrizescalar_dimensiones
    	j imprimir_matriz
    imprimir_matriz:
        lw t3, 0(t2) # t3 = numero de filas
        lw t4, 4(t2) # t4 = numero de columnas

        li t5, 0 # contador de filas
    row_loop:
        bge t5, t3, end_row_loop
        li t6, 0 # contador de columnas
    column_loop:
        bge t6, t4, end_column_loop

        # Mapeo lexicografico
        mul a0, t5, t4 # a0 = indice_fila * numero columnas
        add a0, a0, t6 # a0 += indice columna
        li t0, 4       # t0 = 4 (tamano de una palabra)
        mul a0, a0, t0 # a0 = a0 * 4
        add a0, t1, a0 # a0 = a0 + offset
        lw a1, 0(a0)   # cargar el valor obtenido
        mv t0, a1
	# Imprimir cierre de corchete
	la a0, msg_abrir_corchete
	li a7, 4
	ecall
	
 	#Imprimir número de fila
	mv a0, t5
	li a7, 1
	ecall

	# Imprimir coma
	la a0, msg_coma
	li a7, 4
	ecall

	# Imprimir número de columna
	mv a0, t6
	li a7, 1
	ecall
            	
	# Imprimir cierre de corchete
	la a0, msg_cerrar_corchete
	li a7, 4
	ecall
	
        # imprimir valor de la celda
        mv a1, t0
        mv a0, a1
        li a7, 1
        ecall
        
        la a0, msg_nueva_linea
        li a7, 4
        ecall

        addi t6, t6, 1 # incremental contador columnas
        j column_loop
    end_column_loop:
        addi t5, t5, 1 # incrementar contador filas
        j row_loop
    end_row_loop:

    end_macro:
    .end_macro
#----------------------------- END MACRO imprimir_valores_matriz --------------------------

#--------------------------------- MACRO realizar operaciones ----------------------------
	.macro realizar_operaciones (%numero_matriz) #TODO: pendiente de implementar
   		beqz %numero_matriz, matriz1

   		matriz1:
   			la a0, matriz1_dimensiones
       			lw t0, 0(a0) #t0 tiene las filas
       			 
       			la a0, matriz1_dimensiones
       			lw t1, 4(a0) # t1 tiene columnas
       			 
       			
       			j end_macro
			

   		end_macro:
		.end_macro
#----------------------------- END MACRO realizar operaciones --------------------------
#------------------------------ MACRO ESCALAR --------------------------------------
	.macro escalar_matriz (%matriz1, %k, %matriz_resultado, %filas, %columnas)
    		# Iniciar contadores 
		mv a1, t1
    		li t1, 11 # Numero asignado a matriz escalar
    		almacenar_dimensiones_matriz(t1, %filas, %columnas)
    		mv t1, a1
    		li t0, 0 # contador fila
    		li t1, 0 # contador columna
    		
    		sumar_filas:
    			mv a2, %filas
    			bge t0, %filas, terminar_suma # if t0 == filas terminar

    			# Reiniciar contador columnas
    			li t1, 0
    			sumar_columnas:
    				mv a3, %columnas
    				bge t1, %columnas, terminar_columnas # if t1 == columnas, seguir con la siguiente fila

    				# Realizar calculo de posicion en memoria
    				li t2, 4 # Tamano de un elemento
    				mul t3, t0, %columnas
    				add t3, t3, t1
    				mul t3, t3, t2

    				# Cargar a t4 elementos de la matriz
    				la t4, %matriz1
    				add t4, t4, t3
    				lw t5, 0(t4) # cargar en t5 valor en celda
    				 
    				# Realizar la suma entre valores en posicion [filas, columnas]
    				mul t5, t5, %k

    				# Almacenar resultado en matriz_resultado
    				la t4, matriz_resultado
    				add t4, t4, t3
    				sw t5, 0(t4)
    				
    				addi t1, t1, 1
    				mv %columnas, a3
    				j sumar_columnas

    			terminar_columnas:
    				addi t0, t0, 1 # Incrementar contador columnas
    				mv %filas, a2
    				j sumar_filas

    		terminar_suma:
	.end_macro
#---------------------------------- END MACRO ESCALAR ---------------------------------

#------------------------------ MACRO SUMAR --------------------------------------
	.macro suma_matrices (%matriz1_letra, %matriz2_letra, %matriz_resultado)
    	     # Iniciar contadores 
             obtener_matriz1(%matriz1_letra)
	     obtener_matriz2(%matriz2_letra)    		
	     	
             operar:
		obtener_dimensiones(%matriz1_letra)
    		li t1, 10
    		almacenar_dimensiones_matriz(t1, s6, s7)
    		mv t1, a1
    		li t0, 0 # contador fila
    		li t1, 0 # contador columna
    		
    		mv a0, s10
    		li a7, 1
    		ecall
    		sumar_filas:
    			mv a2, s6
    			bge t0, s6, terminar_suma # if t0 == filas terminar

    			# Reiniciar contador columnas
    			li t1, 0
    			sumar_columnas:
    				mv a3, s7
    				bge t1, s7, terminar_columnas # if t1 == columnas, seguir con la siguiente fila

    				# Realizar calculo de posicion en memoria
    				li t2, 4 # Tamano de un elemento
    				mul t3, t0, s7
    				add t3, t3, t1
    				mul t3, t3, t2

    				# Cargar a t4 elementos de la matriz
    				mv t4, a5
    				add t4, t4, t3
    				lw t5, 0(t4) # cargar en t5 valor en celda
    				mv t4, a6
    				add t4, t4, t3
    				lw t6, 0(t4) #cargar a t6 valor en celda

    				# Realizar la resta entre valores en posicion [filas, columnas]
    				add t5, t5, t6

    				# Almacenar resultado en matriz_resultado
    				la t4, matriz_resultado
    				add t4, t4, t3
    				sw t5, 0(t4)
    				
    				addi t1, t1, 1
    				mv s7, a3
    				j sumar_columnas

    			terminar_columnas:
    				addi t0, t0, 1 # Incrementar contador columnas
    				mv s6, a2
    				j sumar_filas

    		terminar_suma:
	.end_macro
#---------------------------------- END MACRO SUMAR ---------------------------------
#-------------------------------- MACRO RESTA --------------------------------------
	.macro resta_matrices (%matriz1_letra, %matriz2_letra, %matriz_resultado)
    	     # Iniciar contadores 
             obtener_matriz1(%matriz1_letra)
	     obtener_matriz2(%matriz2_letra)    		
	     	
             operar:
		obtener_dimensiones(%matriz1_letra)
    		li t1, 10
    		almacenar_dimensiones_matriz(t1, s6, s7)
    		mv t1, a1
    		li t0, 0 # contador fila
    		li t1, 0 # contador columna
    		
    		mv a0, s10
    		li a7, 1
    		ecall
    		restar_filas:
    			mv a2, s6
    			bge t0, s6, terminar_resta # if t0 == filas terminar

    			# Reiniciar contador columnas
    			li t1, 0
    			restar_columnas:
    				mv a3, s7
    				bge t1, s7, terminar_columnas # if t1 == columnas, seguir con la siguiente fila

    				# Realizar calculo de posicion en memoria
    				li t2, 4 # Tamano de un elemento
    				mul t3, t0, s7
    				add t3, t3, t1
    				mul t3, t3, t2

    				# Cargar a t4 elementos de la matriz
    				mv t4, a5
    				add t4, t4, t3
    				lw t5, 0(t4) # cargar en t5 valor en celda
    				mv t4, a6
    				add t4, t4, t3
    				lw t6, 0(t4) #cargar a t6 valor en celda

    				# Realizar la resta entre valores en posicion [filas, columnas]
    				sub t5, t5, t6

    				# Almacenar resultado en matriz_resultado
    				la t4, matriz_resultado
    				add t4, t4, t3
    				sw t5, 0(t4)
    				
    				addi t1, t1, 1
    				mv s7, a3
    				j restar_columnas

    			terminar_columnas:
    				addi t0, t0, 1 # Incrementar contador columnas
    				mv s6, a2
    				j restar_filas

    		terminar_resta:
	.end_macro
	
#--------------------------------- MACRO OBTNER MATRIX POR LETRA  --------------------------------	
	.macro obtener_matriz1(%letra)
	     li s7, 'A'
	     beq s7, %letra, usar_matriz1
	     li s7, 'B'
	     beq s7, %letra, usar_matriz2
	     li s7, 'C'
	     beq s7, %letra, usar_matriz3
	     li s7, 'D'
	     beq s7, %letra, usar_matriz4
	     li s7, 'Z'
	     beq s7, %letra, usar_matriztemp
             li s7, -1
	     beq s7, %letra, usar_matriztemp
	     	     
	     usar_matriz1:
	     	la a5, matriz1
	     	j end_macro
	     usar_matriz2:
	     	la a5, matriz2
	     	j end_macro
	     usar_matriz3:
	     	la a5, matriz3
	     	j end_macro
             usar_matriz4:
	     	la a5, matriz4
	     	j end_macro
	     usar_matriztemp:
		la a5, matriz_resultado
	     	j end_macro
	  end_macro:
	  .end_macro
	 .macro obtener_matriz2(%letra)
	     li s7, 'A'
	     beq s7, %letra, usar_matriz1
	     li s7, 'B'
	     beq s7, %letra, usar_matriz2
	     li s7, 'C'
	     beq s7, %letra, usar_matriz3
	     li s7, 'D'
	     beq s7, %letra, usar_matriz4
	     li s7, 'Z'
	     beq s7, %letra, usar_matriztemp
	     li s7, -1
	     beq s7, %letra, usar_matriztemp
	     
	     usar_matriz1:
	     	la a6, matriz1
	     	j end_macro
	     usar_matriz2:
	     	la a6, matriz2
	     	j end_macro
	     usar_matriz3:
	     	la a6, matriz3
	     	j end_macro
             usar_matriz4:
	     	la a6, matriz4
	     	j end_macro
	     usar_matriztemp:
		la a6, matriz_resultado
	     	j end_macro
	  end_macro:
	  .end_macro
#-------------------------- MACRO obtener dimensiones -------------------	    
	.macro obtener_dimensiones(%letra)
	     li s9, 'A'
	     beq s9, %letra, usar_matriz1
	     li s9, 'B'
	     beq s9, %letra, usar_matriz2
	     li s9, 'C'
	     beq s9, %letra, usar_matriz3
	     li s9, 'D'
	     beq s9, %letra, usar_matriz4
	     
	     usar_matriz1:
	     	la a0, matriz1_dimensiones
	     	lw s6, 0(a0)
	     	lw s7, 4(a0)
	     	j end_macro
	     usar_matriz2:
	     	la a0, matriz2_dimensiones
	     	lw s6, 0(a0)
	     	lw s7, 4(a0)
	     	j end_macro
	     usar_matriz3:
	     	la a0, matriz3_dimensiones
	     	lw s6, 0(a0)
	     	lw s7, 4(a0)
	     	j end_macro
	     usar_matriz4:
	     	la a0, matriz4_dimensiones
	     	lw s6, 0(a0)
	     	lw s7, 4(a0)  
	     	j end_macro            
	  end_macro:
	  .end_macro	     	 	     	
#---------------------------------- END MACRO RESTA ---------------------------------
#-------------------------------- MACRO MULTIPLICACION --------------------------------------
	.macro multiplicacion_matrices (%matriz1_letra, %matriz2_letra, %matriz_resultado)
    	     # Iniciar contadores 
             obtener_matriz1(%matriz1_letra)
	     obtener_matriz2(%matriz2_letra)    		
	     	
             operar:
		obtener_dimensiones(%matriz1_letra)
    		li t1, 10
    		almacenar_dimensiones_matriz(t1, s6, s7)
    		mv t1, a1
    		li t0, 0 # contador fila
    		li t1, 0 # contador columna
    		
    		mv a0, s10
    		li a7, 1
    		ecall
    		multiplicar_filas:
    			mv a2, s6
    			bge t0, s6, terminar_multiplicacion # if t0 == filas terminar

    			# Reiniciar contador columnas
    			li t1, 0
    			multiplicar_columnas:
    				mv a3, s7
    				bge t1, s7, terminar_columnas # if t1 == columnas, seguir con la siguiente fila

    				# Realizar calculo de posicion en memoria
    				li t2, 4 # Tamano de un elemento
    				mul t3, t0, s7
    				add t3, t3, t1
    				mul t3, t3, t2

    				# Cargar a t4 elementos de la matriz
    				mv t4, a5
    				add t4, t4, t3
    				lw t5, 0(t4) # cargar en t5 valor en celda
    				mv t4, a6
    				add t4, t4, t3
    				lw t6, 0(t4) #cargar a t6 valor en celda

    				# Realizar la resta entre valores en posicion [filas, columnas]
    				mul t5, t5, t6

    				# Almacenar resultado en matriz_resultado
    				la t4, matriz_resultado
    				add t4, t4, t3
    				sw t5, 0(t4)
    				
    				addi t1, t1, 1
    				mv s7, a3
    				j multiplicar_columnas

    			terminar_columnas:
    				addi t0, t0, 1 # Incrementar contador columnas
    				mv s6, a2
    				j multiplicar_filas

    		terminar_multiplicacion:
	.end_macro
#---------------------------------- END MACRO MULTIPLICACION ---------------------------------
##################################### END MACROS ####################################
mostrar_detalle:
    
    li t2, 1
    #imprimir_valores_matriz(t1) #TODO: unicamente para verificacion de datos
    li t1, 0 # Inicializar contador de matrices
    la a0, msg_input_operacion
    li a7, 4
    ecall
    la a0, cadena_a_operar
    li a1, 100
    li a7, 8
    ecall
     
    
    #Esto es solo para verificar macros
    #li t0, 'A'
    #li t1, 'B'
    #suma_matrices(t0, t1, matriz_resultado)  # %matriz1_numero, %matriz2_numero, %matriz_resultado
    #li t1, 10
    #imprimir_valores_matriz(t1)
    
    li t1, 0
    
evaluar_expresion:
    la a0, cadena_a_operar
    li a7, 4
    ecall
    lbu t1, 0(a0)
    li t2, 90
    bne t1, t2, continuar_evaluacion
    lbu t1, 1(a0)
    beqz t1, finalizar
    j continuar_evaluacion
     
no_parenthesis:
    la a0, cadena_a_operar
    
    jal ra, buscar_operador
     
continuar_evaluacion:
    #jal ra, encontrar_parentesis
    #beqz a0, no_parenthesis
    
    #la a0, substring_buffer
    la a0, cadena_a_operar
    jal ra, buscar_operador

    
encontramos_substring:
    la a0, substring_buffer
    li a7, 4
    ecall
    
buscar_operador:
    li t0, 0
    li t2, -1
    li t3, -1
    
    loop_buscar:
    	lbu t1, 0(a0)
    	beq t1, zero, terminar_busqueda_operador
    	mv t6, t1
    	li t4, 43 #ascii de +
    	beq t1, t4, suma_encontrada  	

    	li t4, 45 #ascii de -
    	beq t1, t4, resta_encontrada  	
    	
    	li t4, 42 #ascii de *
    	beq t1, t4, multiplicacion_encontrada  	    	
    	 
    	addi a0, a0, 1
    	addi t0, t0, 1
    	mv s10, t1
    	j loop_buscar
    
    siguiente_caracter:
        addi a0, a0, 1
        addi t0, t0, 1
        j loop_buscar
        
          
    suma_encontrada:
        mv s2, t0 #asignar index de signo
        mv t2, s10 #asignar a t2 valor de primera matriz (A, B, C, etc)
        addi a0, a0, 1
        j parsear_derecha_matriz

    resta_encontrada:
        mv s2, t0 #asignar index de signo
        mv t2,s10 #asignar a t2 valor de primera matriz (A, B, C, etc)
        addi a0, a0, 1
        j parsear_derecha_matriz
                
    multiplicacion_encontrada:
        mv s2, t0 #asignar index de signo
        mv t2, s10 #asignar a t2 valor de primera matriz (A, B, C, etc)
        addi a0, a0, 1
        j parsear_derecha_matriz
        
    parsear_derecha_matriz:
        lbu t1, 0(a0)
        beq t1, zero, terminar_parseo
        mv t3, t1
        j terminar_parseo
        
    terminar_parseo:
        li t4, 43 #ascii de +
    	beq t6, t4, realizar_suma

    	li t4, 45 #ascii de -
    	beq t6, t4, realizar_resta	
    	
    	li t4, 42 #ascii de *
    	beq t6, t4, realizar_multiplicacion 	
    	j finalizar
        
    realizar_suma:
        suma_matrices(t2, t3, matriz_resultado)
    	li t1, 10
    	imprimir_valores_matriz(t1)
    	la t1, cadena_a_operar   # Load address of the string into t1
    	addi s2, s2, -1
    	add t1, t1, s2           # Calculate the address to start replacement

    	li t3, 'Z'               # Replacement character
    	sb t3, 0(t1) 
    	j shift_loop
    	 
    	
    realizar_multiplicacion:
        multiplicacion_matrices(t2, t3, matriz_resultado)
    	li t1, 10
    	imprimir_valores_matriz(t1)
    	la t1, cadena_a_operar   # Load address of the string into t1
    	addi s2, s2, -1
    	add t1, t1, s2           # Calculate the address to start replacement

    	li t3, 'Z'               # Replacement character
    	sb t3, 0(t1) 
    
    shift_loop:
    	addi t1, t1, 1       # Move to the next character
    	lb t3, 2(t1)         # Load byte from the original string 3 positions ahead
    	sb t3, 0(t1)         # Store it in the current position
   	beq t3, zero, end_shift  # If it's a null terminator, end the loop
    	j shift_loop

    end_shift:   		
    	j evaluar_expresion
     
        
    realizar_resta:
    	resta_matrices(t2, t3, matriz_resultado)
    	li t1, 10
    	imprimir_valores_matriz(t1)
        la t1, cadena_a_operar   # Load address of the string into t1
    	addi s2, s2, -1
    	add t1, t1, s2           # Calculate the address to start replacement

    	li t3, 'Z'               # Replacement character
    	sb t3, 0(t1) 
    	j shift_loop
        
    encontrado: 
    	mv a2, t0
    	jr ra
    
    terminar_busqueda_operador:
        j finalizar
        
    
 
    

encontrar_parentesis:
    li t1, 0  # Inicializar contador

    loop_buscar_cierre:
        lbu t2, 0(a0)  # Cargar el siguiente caracter de la expresion
        beq t2, zero, no_encontrado  # Verificar si aun no ha terminado la expresion

        li t3, 41  # cargar el valor ascii de ')'
        beq t2, t3, cierre_encontrado  # verificar si caracter == ')'

        addi a0, a0, 1  # Continuar recorriendo la expresion
        addi t1, t1, 1  # Incrementar contador
        j loop_buscar_cierre

    cierre_encontrado:
        mv t4, t1
        
        loop_buscar_abrir:
        	beqz t1, no_encontrado
        	
        	addi t1, t1, -1
        	lbu t2, 0(a0)
        	addi a0, a0, -1
        	
        	li t3, 40
        	beq t2, t3, abrir_encontrado
        	j loop_buscar_abrir
        	
    abrir_encontrado:
        #almacenar valores dentro de ()
    	addi a0, a0,2 # nos movemos una posicion para evitar guardar (
    	la t5, substring_buffer # cargar substring en substring_buffer
    	mv t6, t4  # setear el index a donde esta )
	addi t6, t6, -2
	
    	almacenar_substring:
    		ble t6, t1, terminar_almacenamiento
    		lbu t2, 0(a0)
    		sb t2, 0(t5) #guardarlo en el buffer
    		
    		addi a0, a0,1
    		addi t5, t5, 1
    		addi t1, t1, 1
    		j almacenar_substring
    		
    	terminar_almacenamiento:
    		sb zero, 0(t5)
    		jr ra
    	
    no_encontrado:
        li a0, 0  # Retornar -1 si no fue encontrado
        jr ra  # Regresar a donde fue llamado
        
   
        
     
finalizar_evaluacion:
    j finalizar 
 
  
      
finalizar:
    li a7, 10
    ecall