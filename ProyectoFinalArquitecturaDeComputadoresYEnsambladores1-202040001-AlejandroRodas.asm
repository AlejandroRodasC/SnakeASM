; PROYECTO FINAL ARQUITECTURA DE COMPUTADORAS 1 
; Edwin Alejandro Rodas Carranza 202040001
ORG 100H
;--------------Presentacion al inicio del juego-----------------
MOV AH, 09H                 ;funcion para imprimir una cadena
MOV DX, OFFSET primeraLinea ;imprimimos la primera linea
INT 21H                     ;llamamos a la funcion 

MOV DX, 0100H               ;Coordenada en Y=1 y X=0
MOV AH, 02H                 ;Movemos el cursor a la coordenada definida en el registro DX
INT 10H                     ;llamamos a la funcion

MOV AH, 09h                 ;funcion para imprimir una cadena
MOV DX, OFFSET segundaLinea ;imprimimos la segunda linea
INT 21H                     ;llamamos a la funcion

MOV DX, 0200H               ;Coordenada en Y=2 y X=0
MOV AH, 02H                 ;Movemos el cursor a la coordenada definida en el registro DX
INT 10H                     ;llamamos a la funcion

MOV AH, 09h                 ;funcion para imprimir una cadena
MOV DX, OFFSET colores      ;imprimimos los colores
INT 21H                     ;llamamos a la funcion

MOV AH, 01h                 ;función entrada de caracter con eco para el color   
INT 21h                     ;llamamos a la funcion

SUB AL, 30H                 ;enmascaremos el ascii ingresado 
MOV colorSnake,AL           ;guardamos el color del snake

MOV DX, 0300H               ;Coordenada en Y=2 y X=0
MOV AH, 02H                 ;Movemos el cursor a la coordenada definida en el registro DX
INT 10H                     ;llamamos a la funcion

MOV AH, 09h                 ;funcion para imprimir una cadena
MOV DX, OFFSET caracter     ;imprimimos mensaje de caracter
INT 21H

MOV AH, 01h                 ;función entrada de caracter con eco para el caracter   
INT 21h                     ;llamamos a la funcion

MOV caracterSnake, AL       ;guardamos el caracter del snake

MOV AH, 01h                 ;función entrada de caracter con eco   
INT 21h                     ;llamamos a la funcion
CMP AL, 0DH                 ;comparamos si la tecla ingresada es el ENTER
JZ enter                    ;si presiono enter empezara el juego
JNZ noEnter                 ;si no presiono enter dejaremos un mensaje 

enter:

MOV DX, 00H                 ;Coordenada Y=0 y X=0
MOV AH, 02H                 ;Movemos el cursor a la coordenada definida en el registro DX
INT 10H                     ;Llamamos a la funcion

MOV AH, 09h                     ;funcion para imprimir una cadena
MOV DX, OFFSET borrarPantalla   ;imprimimos una cadena que elimina la primera linea que mandamos a imprimir
INT 21H                         ;llamamos a la funcion

MOV DX, 0100H                   ;Coordenadas Y=1 y X=0 (coordenada donde esta la segunda cadena)
MOV AH, 02H                     ;movemos el cursor hacia la coordenada definida en el registro DX
INT 10h                         ;llamamos a la funcion 

MOV AH, 09h                     ;funcion para imprimir una cadena
MOV DX, OFFSET borrarPantalla   ;imprimimos una cadena que elimina la segunda linea que mandamos a imprimir
INT 21H                         ;llamamos a la funcion

MOV DX, 0200H                   ;Coordenadas Y=2 y X=0 (coordenada donde esta la segunda cadena)
MOV AH, 02H                     ;movemos el cursor hacia la coordenada definida en el registro DX
INT 10h                         ;llamamos a la funcion 

MOV AH, 09h                     ;funcion para imprimir una cadena
MOV DX, OFFSET borrarPantalla   ;imprimimos una cadena que elimina la segunda linea que mandamos a imprimir
INT 21H                         ;llamamos a la funcion

MOV DX, 0300H                   ;Coordenadas Y=3 y X=0 (coordenada donde esta la segunda cadena)
MOV AH, 02H                     ;movemos el cursor hacia la coordenada definida en el registro DX
INT 10h                         ;llamamos a la funcion 

MOV AH, 09h                     ;funcion para imprimir una cadena
MOV DX, OFFSET borrarPantalla   ;imprimimos una cadena que elimina la segunda linea que mandamos a imprimir
INT 21H                         ;llamamos a la funcion

MOV DX, 0400H                   ;Coordenadas Y=4 y X=0 (coordenada donde esta la segunda cadena)
MOV AH, 02H                     ;movemos el cursor hacia la coordenada definida en el registro DX
INT 10h                         ;llamamos a la funcion 

MOV AH, 09h                     ;funcion para imprimir una cadena
MOV DX, OFFSET borrarPantalla   ;imprimimos una cadena que elimina la segunda linea que mandamos a imprimir
INT 21H                         ;llamamos a la funcion

MOV DX, 0500H                   ;Coordenadas Y=5 y X=0 (coordenada donde esta la segunda cadena)
MOV AH, 02H                     ;movemos el cursor hacia la coordenada definida en el registro DX
INT 10h                         ;llamamos a la funcion 

MOV AH, 09h                     ;funcion para imprimir una cadena
MOV DX, OFFSET borrarPantalla   ;imprimimos una cadena que elimina la segunda linea que mandamos a imprimir
INT 21H                         ;llamamos a la funcion

JMP inicio             ;empieza el juego
 
inicio: ;iniciar juego
 
cicloJuego:  ;Iniciamos el ciclo del juego
  
MOV     AH, 02H      ;Función para asignar posición del cursor
MOV     DX, snake[0] ;En DX guardamos la fila y columna donde se encontrará la cabeza del snake
INT     10h          ;Movemos el cursor
 
MOV     AL, caracterSnake ;Definimos el caracter que utilizaremos para hacer el snake
MOV     AH, 09H           ;Valor de en AH para 
MOV     BL, colorSnake    ;Definimos el color que tendra el snake 
MOV     CX, 01H           ;Número de caracteres que se escribiran en este ciclo, solo 1 para este caso
INT     10h               ;Imprimimos el caracter
 
MOV     AX, snake[tamaño * 2 - 2]   ;Guardamos la posicion de la cola del snake en el registro AX
MOV     cola, AX                    ;Guardamos esa posicion en la variable cola
 
CALL    moverSnake
 
MOV     DX, cola ;En el registro DX ponemos las coordenadas de la cola
MOV     AH, 02H  ;Funcion para mover el cursor a la posición determinada por DX
INT     10H      ;Movemos el cursor 
 
MOV     AL, ' '  ;printearemos un espacio vacio sobre la cola del snake para que desaparezca
MOV     AH, 09H  ;funcion para escribir un caracter en la posición donde se encuentra
MOV     CX, 01H  ;solo se imprimira un caracter ( un espacio vacío )
INT     10H      ;activamos la funcion 
 
verificarBufferTeclado:   ;chequeamos la ultima tecla presionada 

MOV     AH, 01H  	;obtenemos el estado del buffer del teclado
INT     16H      	;llamamos a la interrupcion 
JZ      noHayTecla   	;si no hay una tecla en espera en el buffer
 
MOV     AH, 00H  ;si hay una tecla en espera la leemos
INT     16h      ;llamamos la interrupcion
 
CMP     AL, 1BH    ;si se presiona la tecla esc 
JE      salir  ;termina el juego
 
MOV     direccionActual, AH ;la direccion actual sera igual a la tecla que presionamos 
 
noHayTecla:
JMP     cicloJuego  ;solamente repetimos el ciclo del juego con la direccion que ya tenemos 
                                                           
salir:
RET
  
moverSnake PROC near ;Inicializamos el procedimiento de movimiento 
    MOV     AX, 40h  ;Movemos a AX el segmento de memoria de la BIOS o sea 40h
    MOV     ES, AX   ;Utilizamos el segmento extra para ubicarnos en el segmento de memoria de la BIOS, así podremos utilizar variables de la BIOS
 
    MOV   DI, tamaño * 2 - 2 ;Guardamos en DI la posición de memoria de la cola (usamos este registro ya que es el menos propenso a cambios)
    MOV   CX, tamaño-1   ;Definimos cuanto durará el loop en el que se cambiaran los valores del arreglo.
    
      ajustarArreglo:
      MOV   AX, snake[DI-2] ;Guardamos en AX las coordenadas del snake definididas con el segmento di-2 (Las coordenadas del caracter que tiene enfrente). 
      MOV   snake[DI], AX   ;Le agregamos esas coordenadas al caracter en el que se esta trabajando
      SUB   DI, 2           ;reducimos el registro DI para hacer referencia al siguiente caracter de nuestro snake
      LOOP  ajustarArreglo      ;rehacemos el ciclo
      
      CMP  direccionActual, abajo     ;compara si la dirección actual del snake es hacia abajo
      JE    moverAbajo                ;si es así salta hacia la funcion que le dara direccion a la cabeza hacia arriba
      
      CMP  direccionActual, derecha    ;compara si la dirección actual del snake es hacia la derecha
      JE   moverDerecha               ;si es así salta hacia la funcion que le dara direccion a la cabeza hacia la derecha
      
      CMP  direccionActual, arriba    ;compara si la dirección actual del snake es hacia arriba
      JE   moverArriba                ;si es así salta hacia la funcion que le dara direccion a la cabeza hacia arriba
      
      CMP  direccionActual, izquierda ;compara si la dirección actual del snake es hacia la izquierda
      JE   moverIzquierda             ;si es así salta hacia la funcion que le dara dirección a la cabeza hacia la izquierda
      
      ;Para el movimiento debemos tener en cuenta que los movimientos hacia la izquierda restan las posiciones en el eje X
      ;y hacia la derecha suman. En el eje Y cuando se mueve hacia abajo aumenta las coordenadas y cuando se mueve hacia arriba se
      ;restan.
      
      ;PARA LA TERMINAL EL EJE X SOLO SE EXTIENDE HACIA LA DERECHA Y EL EJE Y SOLO HACIA ABAJO.
      
      moverIzquierda:       ;Movimiento hacia la izquierda  
      MOV   AL, B.snake[0]  ;Con el prefijo b. llamamos el byte 0, que nos dice la coordenada en el eje X de la cabeza del snake  
      DEC   AL              ;Como el snake se dirige hacia la izquierda, restamos 1 posicion en el eje X
      MOV   B.snake[0], AL  ;Enviamos la nueva posicion en el eje X de nuestra cabeza al arreglo
      CMP   AL, -1          ;Comparamos si la nueva posicion de la cabeza esta fuera de nuestro eje X (en la columna -1)
      JNE   finMovimiento   ;si no es así terminamos el movimiento
      MOV   AL, ES:[4ah]    ;si esta saliendo, movemos al registro AL la ultima columna de nuestra pantalla (Esta aún no es visible)
      DEC   AL              ;Le restamos una posicion, dandonos como resulta la primera columna visible en pantalla
      MOV   B.snake[0], AL  ;Ponemos la cabeza en esta nueva posicion 
      JMP   finMovimiento   ;terminamos el movimiento
      
      moverDerecha:         ;Movimiento hacia la derecha
      MOV   AL, B.snake[0]  ;Con el prefijo b. llamamos el byte 0, que nos dice la coordenada en el eje X de la cabeza del snake 
      INC   AL              ;Como el snake se dirige hacia la derecha, sumamos 1 posicion en el eje X
      MOV   B.snake[0], AL  ;Enviamos la nueva posicion en el eje X de nuestra cabeza al arreglo  snake
      CMP   AL, ES:[4AH]    ;Comparamos si la cabeza esta en la ultima columna de nuestra terminal
      JB    finMovimiento   ;si no es asi, termina el movimiento
      MOV   B.snake[0], 0   ;si es así, movemos la cabeza del snake a la columna 0, o sea la primera columna de izquierda a derecha
      JMP   finMovimiento   ;terminamos el movimiento
     
      moverArriba:          ;Movimiento hacia arriba
      MOV   AL, b.snake[1]  ;Con el prefijo b. llamamos el byte 1, que nos dice la coordenada en el eje Y de la cabeza del snake
      DEC   AL              ;Como el snake se dirige hacia arriba, restamos 1 posicion en el eje Y
      MOV   B.snake[1], AL  ;Enviamos la nueva posicion en el eje Y de nuestra cabeza al arreglo snake
      CMP   AL, -1          ;Comparamos si esta nueva posicion se encuentra fuera de los limites de la terminal
      JNE   finMovimiento   ;si no es así termina el movimiento 
      MOV   AL, ES:[84H]    ;si es así, guardamos la posicion de nuestra ultima fila en el registro al
      MOV   B.snake[1], AL  ;y al byte de la cabeza que determina la coordenada en Y, le enviamos la posicion de la esta ultima fila
      JMP   finMovimiento   ;terminamos el movimiento
      
      moverAbajo:           ;Movimiento hacia abajo      
      MOV   AL, B.snake[1]  ;Con el prefijo b. llamamos el byte 1, que nos dice la coordenada en el eje Y de la cabeza del snake
      INC   AL              ;Como el snake se dirige hacia abajo, restamos 1 posicion en el eje Y
      MOV   B.snake[1], AL  ;Enviamos la nueva posicion en el eje Y de nuestra cabeza al arreglo snake
      CMP   AL, ES:[84H]    ;Comparamos si la cabeza esta en la ultima fila de nuestra terminal
      JBE   finMovimiento   ;si no es así, continua el movimiento
      MOV   B.snake[1], 0   ;si es así, movemos la cabeza del snake a la fila numero 0, o sea la primera fila de arriba a abajo
      JMP   finMovimiento   ;terminamos el movimiento
 
      finMovimiento:        ;termina el procedimiento de movimiento
      RET                   ;retornamos
      
moverSnake ENDP  ;terminamos la funcion de movimiento

noEnter:
MOV DH, 03H                 ;Coordenada en Y=3
MOV DL, 00H                 ;Coordenada en X=0
MOV AH, 02H                 ;Movemos el cursor a la coordenada definida en el registro DX
INT 10H                     ;llamamos a la funcion

MOV AH, 09h                 ;funcion para imprimir una cadena
MOV DX, OFFSET mensajito    ;imprimimos una cadena que deja un mensaje al usuario que no presiono ENTER
INT 21H                     ;llamamos a la funcion

MOV DH, 04H                 ;Coordenada en Y=4
MOV DL, 00H                 ;Coordenada en X=0
MOV AH, 02H                 ;Movemos el cursor a la coordenada definida en el registro DX
INT 10H                     ;llamamos a la funcion

MOV AH, 09h                 ;funcion para imprimir una cadena
MOV DX, OFFSET mensajito2   ;imprimimos una cadena que deja un mensaje al usuario que no presiono ENTER
INT 21H                     ;llamamos a la funcion

miniCiclo0:                 ;Ciclo de espera para mostrar el primer mensaje
DEC cicloEspera
CMP cicloEspera, 0
JNZ miniCiclo0

MOV DH, 05H                 ;Coordenada en Y=4
MOV DL, 00H                 ;Coordenada en X=0
MOV AH, 02H                 ;Movemos el cursor a la coordenada definida en el registro DX
INT 10H                     ;llamamos a la funcion

MOV AH, 09h                 ;funcion para imprimir una cadena
MOV DX, OFFSET broma        ;imprimimos una cadena que deja un mensaje al usuario que es una broma
INT 21H                     ;llamamos a la funcion

MOV AH, 09h                 ;funcion para imprimir una cadena
MOV DX, OFFSET En3          ;imprimimos una cadena que deja un mensaje al usuario que es una broma
INT 21H                     ;llamamos a la funcion

MOV cicloEspera, 15h
miniCiclo1:                 ;ciclo de espera 1
DEC cicloEspera
CMP cicloEspera, 0
JNZ miniCiclo1

MOV AH, 09h                 ;funcion para imprimir una cadena
MOV DX, OFFSET En2          ;imprimimos una cadena que deja un mensaje al usuario que es una broma
INT 21H

MOV cicloEspera, 15h        ;Ciclo de espera 2
miniCiclo2:
DEC cicloEspera
CMP cicloEspera, 0
JNZ miniCiclo2

MOV AH, 09h                 ;funcion para imprimir una cadena
MOV DX, OFFSET En1          ;imprimimos una cadena que deja un mensaje al usuario que es una broma
INT 21H

MOV cicloEspera, 15h        ;Ciclo de espera 3
miniCiclo3:
DEC cicloEspera
CMP cicloEspera, 0
JNZ miniCiclo3

JMP enter

RET

primeraLinea DB       "******************* BIENVENIDO A SNAKE (PERO SIN FRUTAS) ***********************$"
segundaLinea DB       " ELIGE EL COLOR Y CARACTER DE TU SNAKE Y LUEGO PRESIONA 'ENTER' PARA EMPEZAR ***$"
colores DB            "***** AZUL(1) VERDE (2) CYAN (3) ROJO (4) MAGENTA (5) CAFE (6) GRIS (7) ********$"
caracter DB           "               INGRESA EL CARACTER QUE SE USARA PARA TU SNAKE: $"
borrarPantalla DB     "                                                                                         $"
mensajito DB          "********************* SOLO DEBIAS PRESIONAR ENTER >:( **************************$" 
mensajito2 DB         "******************** AHORA DEBES RECARGAR EL CODIGO :P *************************$"
broma DB              "                 NO TE CREAS :D EMPEZAMOS EN $"
En3 DB "3...$"
En2 DB "2...$"
En1 DB "1...$"
colorSnake DB 0H
caracterSnake DB 0H
cicloEspera DB 25H
tamaño  EQU 5          ;Definimos el tamaño que tendra nuestro snake
snake DW tamaño DUP(0) ;Reservamos un arreglo de  5 palabras (tamaño del snake definido antes) cada palabra 
                       ;inicializada en 00H estas palabras nos serviran para guardar las coordenadas de cada caracter del snake  
cola DW 00H            ;Reservamos el espacio en memoria para la cola del snake  
;Codigos de las teclas de direccion
arriba    EQU  48H   ;Definimos una variable en la que almacenamos el hexadecimal de la flecha arriba
abajo     EQU  50H   ;Definimos una variable en la que almacenamos el hexadecimal de la flecha abajo
izquierda EQU  4BH   ;Definimos una variable en la que almacenamos el hexadecimal de la flecha izquierda
derecha   EQU  4DH   ;Definimos una variable en la que almacenamos el hexadecimal de la flecha derecha 
direccionActual DB abajo ;Definimos la dirección por defecto que tendra el snake al iniciar, en este caso empezara hacia abajo
END