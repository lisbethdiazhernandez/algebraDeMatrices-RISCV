.global programa

.data
    # Mensajes para interacción con el usuario
    msg_input_nummatrices: 
        .string "Ingresa la cantidad de matrices a utilizar:\0"  # Mensaje para cantidad de matrices
    msg_input_numfilas: 
        .string "Ingresa el número de filas para la matriz: \0"  # Mensaje para número de filas
    msg_input_numcolumnas: 
        .string "Ingresa el número de columnas para la matriz: \0"  # Mensaje para número de columnas
    msg_matriz_num: 
        .string "Matriz número: \0"  # Mensaje para número de matriz
    msg_detalle_matrices: 
        .string "Detalle de matrices:\n\0"  # Mensaje para mostrar detalle de matrices
    msg_input_celda:
        .string "Ingresa el valor para la celda [ \0"  # Mensaje para ingresar valor de celda
    msg_coma:
        .string ", \0"  # Coma para formato
    msg_cerrar_corchete:
        .string "]: \0"  # Cierre de corchete para formato

    # Variables para controlar tamaño y dimensiones
    matriz_dim: 
        .align 2  # Alineación para dimensiones de matriz
    matrix_size: 
        .word 0   # Variable para tamaño de matriz
    msg_input_operation:
        .string "Ingresa la operacion a realizar (ej. AB para A+B):\0"  # Mensaje para operación
    msg_result:
        .string "El resultado de la operacion es:\n\0"  # Mensaje para mostrar resultado
    msg_newline:
        .string "\n\0"  # Salto de línea
    input_buffer: 
        .space 3  # Espacio para entrada de operación
    matrix_dimensions: 
        .align 2      
        .space 64  # Espacio para almacenar dimensiones de las matrices
    matrix_counter: 
        .align 2   
        .word 0    # Contador de matrices
    matrices_valores:
        .space 4096  # Espacio para valores de las matrices
        .space 64

.text

# Comienzo del programa
programa:
    # Imprimir mensaje para ingresar número de matrices
    la a0, msg_input_nummatrices
    li a7, 4
    ecall

    # Leer el número de matrices
    li a7, 5
    ecall
    mv t0, a0  # Guarda la cantidad de matrices en t0

    # Inicializar contador de matrices
    li t1, 0 

    # Bucle para leer dimensiones de cada matriz
    bucle_matrices:
        bge t1, t0, mostrar_detalle  # Salir del bucle si se han procesado todas las matrices

        # Mostrar número de matriz actual
        la a0, msg_matriz_num
        li a7, 4
        ecall

        # Imprimir y leer número de filas
        la a0, msg_input_numfilas
        li a7, 4
        ecall
        li a7, 5
        ecall
        mv t2, a0  # Guarda el número de filas en t2

        # Imprimir y leer número de columnas
        la a0, msg_input_numcolumnas
        li a7, 4
        ecall
        li a7, 5
        ecall
        mv t3, a0  # Guarda el número de columnas en t3

        # Calcular y almacenar tamaño de la matriz
        mul t4, t2, t3  # t4 = filas * columnas
        slli t4, t4, 2  # Multiplica por 4 (tamaño de cada elemento en bytes)
        la t5, matrix_size
        sw t4, 0(t5)    # Almacena el tamaño de la matriz

        # Almacenar dimensiones de la matriz
        slli t4, t1, 3  # Calcula desplazamiento para dimensiones de matriz
        la t5, matrix_dimensions
        add t5, t5, t4  # Agrega desplazamiento a la dirección base
        sw t2, 0(t5)    # Almacena número de filas
        sw t3, 4(t5)    # Almacena número de columnas

        # Bucle para leer los valores de cada celda
        li t6, 0  # Inicializa contador de filas
        lea_filas:
            bge t6, t2, fin_lea_filas  # Sale del bucle si se han leído todas las filas
            li t4, 0  # Inicializa contador de columnas

            # Bucle para cada columna
            bucle_columnas:
                bge t4, t3, fin_bucle_columnas  # Sale del bucle si se han leído todas las columnas

                # Solicitar y leer valor de la celda
                la a0, msg_input_celda
                li a7, 4
                ecall

                # Imprimir número de fila y columna
                mv a0, t6
                li a7, 1
                ecall
                la a0, msg_coma
                li a7, 4
                ecall
                mv a0, t4
                li a7, 1
                ecall
                la a0, msg_cerrar_corchete
                li a7, 4
                ecall

                # Leer valor de la celda
                li a7, 5
                ecall

                # Calcular y almacenar dirección de memoria para el valor
                slli t4, t1, 3  # Calcula desplazamiento para dimensiones de matriz
                la t5, matrix_dimensions
                add t5, t5, t4  # Agrega desplazamiento a la dirección base
                sw t2, 0(t5)    # Almacena número de filas
                sw t3, 4(t5)    # Almacena número de columnas

                # Incrementar contador de columnas y volver al bucle
                addi t4, t4, 1
                j bucle_columnas

            # Fin del bucle de columnas, incrementar fila y volver al bucle
            fin_bucle_columnas:
                addi t6, t6, 1
                j lea_filas

        # Fin del bucle de filas, incrementar matriz y volver al bucle
        fin_lea_filas:
            addi t1, t1, 1
            j bucle_matrices

    # Mostrar detalle de matrices
    mostrar_detalle:
        la a0, msg_detalle_matrices
        li a7, 4
        ecall

        # Solicitar y leer operación
        li t1, 0  # Reiniciar contador
        la a0, msg_input_operation
        li a7, 4
        ecall

        # Leer operación en el buffer de entrada
        la a0, input_buffer
        li a1, 3
        li a7, 8
        ecall

        # Cargar los caracteres de las matrices y convertirlos a índices
        lbu t1, 0(a0)  # Carga primer carácter de matriz ('A')
        lbu t2, 1(a0)  # Carga segundo carácter de matriz ('B')
        li t3, 65      # Valor ASCII de 'A'
        sub t1, t1, t3  # Convierte ASCII a índice (base 0)
        sub t2, t2, t3  # Convierte ASCII a índice (base 0)

        # Verificar que los índices estén en el rango válido
        li t3, 8
        blt t1, t3, valid_matrix_index_A
        j error_invalid_matrix_index
    valid_matrix_index_A:
        blt t2, t3, valid_matrix_index_B
        j error_invalid_matrix_index
    valid_matrix_index_B:

        # Cargar dimensiones de la primera matriz
        slli t0, t1, 3  # Calcular desplazamiento para dimensiones de matriz
        la t5, matrix_dimensions
        add t5, t5, t0  # Obtener dirección de las dimensiones para la primera matriz
        lw t3, 0(t5)    # Cargar número de filas de la primera matriz en t3
        lw t4, 4(t5)    # Cargar número de columnas de la primera matriz en t4

        # Llamar a la subrutina para la adición de matrices
        jal matrix_addition

        # Finalizar programa
        j finalizar

# Subrutina para adición de matrices
matrix_addition:
    li t6, 0 # Inicializar índice de fila para la adición de matrices
 
matrix_addition_row_loop:
    bge t6, t3, matrix_addition_end # Check if all rows are processed
    li t5, 0 # Initialize column index for this row

matrix_addition_col_loop:
    bge t5, t4, matrix_addition_row_end # Check if all columns are processed

    # Load dimensions of the first matrix (assuming each dimension is a word)
    slli t0, t1, 3
    la t5, matrix_dimensions
    add t5, t5, t0
    lw t3, 0(t5)    # Load number of rows of the first matrix into t3
    lw t4, 4(t5)    # Load number of columns of the first matrix into t4

    # Load matrix_size and calculate base addresses
    la t5, matrix_size
    lw t5, 0(t5)    # Load matrix size into t5

    # Calculate base addresses for the two matrices
    mul t6, t1, t5  # Offset for first matrix (A)
    mul t0, t2, t5  # Offset for second matrix (B)

    la t1, matrices_valores  # Base address of matrices storage
    add t1, t1, t6  # Base address of first matrix (A)
    add t2, t1, t0  # Base address of second matrix (B)

    # Add the elements
    add a2, a0, a1     # Sum of elements

    # Print [row index, column index]: cell_value
    # Printing row index
    mv a0, t6         
    li a7, 1          
    ecall

    # Printing comma
    li a7, 4          
    la a0, msg_coma   
    ecall

    # Printing column index
    mv a0, t5         
    li a7, 1          
    ecall

    # Printing closing bracket and colon
    li a7, 4          
    la a0, msg_cerrar_corchete   
    ecall

    # Printing cell value
    mv a0, a2         
    li a7, 1          
    ecall

    # Printing newline
    li a7, 4          
    la a0, msg_newline   
    ecall

    addi t5, t5, 1    # Increment column index
    j matrix_addition_col_loop

matrix_addition_row_end:
    addi t6, t6, 1    # Increment row index
    j matrix_addition_row_loop

matrix_addition_end:
    ret               # Return from subroutine

error_invalid_matrix_index:
    li a7, 10
    ecall
finalizar:
    li a7, 10
    ecall
