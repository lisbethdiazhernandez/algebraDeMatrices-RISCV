# algebraDeMatrices-RISCV
El proyecto consiste en realizar una calculadora de matrices utilizando RISC- V, es decir, que el programa desarrollado en lenguaje ensamblador será capaz de realizar todas las operaciones de algebra de matrices sobre N cantidad de matrices ingresadas por el usuario y operar según sea lo solicitado.

*Características*
Entrada dinámica para el número de matrices y sus dimensiones.
Soporte para operaciones básicas de matrices:
Suma (+)
Resta (-)
Multiplicación (*)
Multiplicación escalar
Procesamiento de expresiones complejas con priorización de operaciones (paréntesis, multiplicación, suma/resta, escalares).
Entrada interactiva del usuario para los elementos de la matriz y operaciones.

*Segmento de Datos*
El segmento .data del programa incluye la asignación de espacio para hasta nueve matrices y varias cadenas utilizadas para mensajes y prompts al usuario. Cada matriz tiene asignados 400 bytes.


*Macros*
Se utilizan varias macros para simplificar tareas comunes como almacenar valores en matrices, imprimir dimensiones y valores de matrices, y realizar operaciones con matrices. Estas macros hacen que el código sea más legible y fácil de mantener.

*Flujo del Programa*
El programa comienza preguntando al usuario el número de matrices y sus dimensiones. Luego toma la entrada para los elementos de cada matriz. Después, el usuario puede ingresar una operación en forma de cadena, como A+B, A*(B-C), etc. El programa analiza esta cadena y realiza las operaciones en el orden correcto.


*Ejemplo de uso*
Entrada:
Número de matrices: 2
Dimensiones de la matriz 1: 2x2
Valores de la matriz 1: 1 2 3 4
Dimensiones de la matriz 2: 2x2
Valores de la matriz 2: 5 6 7 8
Operación: A+B

Salida:
Matriz Resultante:
[0, 0]: 6
[1, 0]: 8
[0, 1]: 10
[1, 1]: 12


*Limitaciones*
La implementación actual soporta un máximo de nueve matrices.
Cada matriz está limitada al tamaño asignado en el segmento .data.