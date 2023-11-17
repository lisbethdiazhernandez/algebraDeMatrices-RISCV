.global programa

.data
    matriz1: .space 400
    matriz2: .space 400
    matriz3: .space 400
    matriz4: .space 400
    matriz5: .space 400
    matriz6: .space 400
    matriz7: .space 400
    matriz8: .space 400
    matriz9: .space 400
    matriz_resultado: .space 400
 
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
#-------------------------------- MACRO operacion escalar ------------------------------
	.macro operacion_escalar (%escalar, %numero_matriz) #TODO: pendiente de terminar
   		beqz %numero_matriz, matriz1
		li t0, 1
    		beq %numero_matriz, matriz1
    		li t1, %escalar
    		 
   		imprimir_matriz1:
        		la t1, matriz1
        		la t2, matriz1_dimensiones
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

  		# imprimir valor de la celda
			mv a0, a1
			li a7, 1
			ecall

		addi t6, t6, 1 # incremental contador columnas
		j column_loop
    	end_column_loop:
        	addi t5, t5, 1 # incrementar contador filas
        	j row_loop
	end_row_loop:
   		end_macro:
		.end_macro
#----------------------------- END MACRO operacion escalar --------------------------
#------------------------------ MACRO SUMAR --------------------------------------
	.macro suma_matrices (%matriz1, %matriz2, %matriz_resultado, %filas, %columnas)
    		# Iniciar contadores 
		mv a1, t1
		
    		li t1, 10
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
    				la t4, %matriz2
    				add t4, t4, t3
    				lw t6, 0(t4) #cargar a t6 valor en celda

    				# Realizar la suma entre valores en posicion [filas, columnas]
    				add t5, t5, t6

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
#---------------------------------- END MACRO SUMAR ---------------------------------
#-------------------------------- MACRO RESTA --------------------------------------
	.macro resta_matrices (%matriz1, %matriz2, %matriz_resultado, %filas, %columnas)
    		# Iniciar contadores 
		mv a1, t1
		
    		li t1, 10
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
    				la t4, %matriz2
    				add t4, t4, t3
    				lw t6, 0(t4) #cargar a t6 valor en celda

    				# Realizar la suma entre valores en posicion [filas, columnas]
    				add t5, t5, t6

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
#---------------------------------- END MACRO RESTA ---------------------------------
##################################### END MACROS ####################################
mostrar_detalle:
    
    li t2, 1
    imprimir_valores_matriz(t1) #TODO: unicamente para verificacion de datos
    li t1, 0 # Inicializar contador de matrices
    la a0, msg_input_operacion
    li a7, 4
    ecall
    li a1, 100
    li a7, 8
    ecall
    
    #volver a imprimir valor a donde apunta t5
    mv t5, a0
    mv a0, t5                   # Asignar valor de t5 a a0
    li a7, 4                    # Imprimir valor para verificar 
    ecall                      
    li t1, 0
    la t6, cadena_a_operar
    
    li t2, 2
    li t3, 2
    suma_matrices(matriz1, matriz2, matriz_resultado, t2, t3)  # %matriz1, %matriz2, %matriz_resultado, %filas, %columnas
    li t1, 10
    imprimir_valores_matriz(t1)
  
 
#verificacion_parentesis: #TODO: convertir en macro
#    lb a0, 0(t5)              # Cargar primer caracter
#    beq a0, zero, finalizo_lectura    # Si el caracter es nulo, ir a finalizo_lectura 
#    li t2, '('                # asignar a t2 valor ASCII de '('
#    li t3, ')'                # asignar a t3 valor ASCII de ')'
#    beq a0, t2, inicia_segmento  # if caracter actual == '(' inicia segmento
#    beq a0, t3, termina_segmento   # if caracter actual == ')' termina segmento
#    bnez t1, almacenar_cadena_operacion      # Guardar valor adentro del parentesis
#    j continuar_verificacion_parentesis

#inicia_segmento:
#    li t1, 1                  # Setear flag se encontro (
#    j continuar_verificacion_parentesis

#termina_segmento:
#    li t1, 0                  # limpiar flag de parentesis
#    sb zero, 0(t6)              
#    j procesar_cadena

#almacenar_cadena_operacion:
#    sb a0, 0(t6)             # Guardar valor en 'cadena_a_operar'
#    addi t6, t6, 1           # Moverse a siguiente posicion en cadena a operar

#continuar_verificacion_parentesis:
#    addi t5, t5, 1           # Moverse a siguiente posicion en input operaciones
#    j verificacion_parentesis

#finalizo_lectura:
#    bnez t1, error           # Los parentesis no son correctos
#    j procesar_cadena

#error:
#    la a0, error_parentesis
#   li a7, 4
#    ecall
#    j finalizar

#procesar_cadena:
#    la a0, se_procedera_operacion
#    li a7, 4
#    ecall
#    la a0, cadena_a_operar   # Cargar a a0 lo obtenido dentro de los parentesis
#    li a7, 4                  
#    ecall 

      
finalizar:
    li a7, 10
    ecall
