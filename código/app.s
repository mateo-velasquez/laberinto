.globl app
app:
    //---------------- Inicialización GPIO --------------------//

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		
	
	// Configurar GPIOs como input:
	mov X21, #0
	str w21, [x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)  

    // Configurar GPIO 2 y 3 como output:
	mov X26, #0x240
	str w26, [x20, 0]  	
	
    //-------------------------------------------- Main code ------------------------------------------------//
    // X0 contiene la dirección base del framebuffer (NO MODIFICAR)

	add x10, x0, 0				// X10 contiene la direccion base del framebuffer
	mov x1, 0x8					// x1 va a a ser un auxiliar
	mov x15, 256				// x15 = 256
	mul x15, x15, x15			// x15 = 2^16
	mul x2, x1, x15				// x2 = 8*2^16 = 2^19 = 2 * 2^18 (Cada pixel avanza cada dos y el otro es el tam)
	mov x17, 512
	add x11, x2, x0				// x11 va a tener el limite de la pantalla	
	mov x16, 512				// x16 = 512
	mov x17, 2					// x17 = 2

	mov w26, 0x8				// Esto selecciona el GPIO 3 (Rojo)
	bl ApagarLed				// Se prende
	mov w26, 0x4				// Esto selecciona el GPIO 2 (Verde)
	bl ApagarLed

PintarFondo:
	mov w3, 0x0821    			// 0x0821 = Casi negro 
	mov x2, 512					// x2 = contador de Y
pintarF1:
	mov x1, 512 				// x1 = X
pintarF0:
	sturh w3, [x10]
	add x10, x10, 2 			// Estoy pasando al siguiente pixel
	sub x1, x1, 1 				// Estoy decrementando x
	cbnz x1, pintarF0			// Comparo si x != 0, y si lo es reitero la iteracion
	sub x2, x2, 1
	cbnz x2, pintarF1			// Si Y != 0, pero llega que x == 0, entonces necesito reiniciar los valores de x

PintarInicio:
	mov w3, 0x8000				// 0x8000 = Rojo Oscuro
	mov x4, 0					// Xi = 0
	mov x5, 288					// Yi = 0
	mov x6, 16					// Xf = 512
	mov x7, 304					// Yf = 16
	bl Cuadrilatero       		// Pintamos la celda de Final

PintarFinal:
	mov w3, 0x0400				// 0x0400 = Verde
	mov x4, 496					// Xi = 0
	mov x5, 48					// Yi = 0
	mov x6, 512					// Xf = 512
	mov x7, 64					// Yf = 16
	bl Cuadrilatero       		// Pintamos la celda de Final

PintarParedes:
	mov w3, 0xF810				// 0xf4b6 = Fucsia
	mov x4, 0					// Xi = 0
	mov x5, 0					// Yi = 0
	mov x6, 512					// Xf = 512
	mov x7, 16					// Yf = 16
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 0					// Xi
	mov x5, 16					// Yi
	mov x6, 16					// Xf
	mov x7, 288					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 0					// Xi
	mov x5, 304					// Yi
	mov x6, 16					// Xf
	mov x7, 512					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 16					// Xi
	mov x5, 496					// Yi
	mov x6, 512					// Xf
	mov x7, 512					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 496					// Xi
	mov x5, 64					// Yi
	mov x6, 512					// Xf
	mov x7, 496					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 496					// Xi
	mov x5, 16					// Yi
	mov x6, 512					// Xf
	mov x7, 48					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 32					// Xi
	mov x5, 32					// Yi
	mov x6, 256					// Xf
	mov x7, 48					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 272					// Xi
	mov x5, 32					// Yi
	mov x6, 320					// Xf
	mov x7, 48					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 368					// Xi
	mov x5, 32					// Yi
	mov x6, 448					// Xf
	mov x7, 48					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 464					// Xi
	mov x5, 32					// Yi
	mov x6, 496					// Xf
	mov x7, 48					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 32					// Xi
	mov x5, 48					// Yi
	mov x6, 48					// Xf
	mov x7, 128					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 32					// Xi
	mov x5, 144					// Yi
	mov x6, 48					// Xf
	mov x7, 256					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 16					// Xi
	mov x5, 272					// Yi
	mov x6, 144					// Xf
	mov x7, 288					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 48					// Xi
	mov x5, 240					// Yi
	mov x6, 64					// Xf
	mov x7, 256					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 64					// Xi
	mov x5, 64					// Yi
	mov x6, 80					// Xf
	mov x7, 256					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 80					// Xi
	mov x5, 160					// Yi
	mov x6, 96					// Xf
	mov x7, 176					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 96					// Xi
	mov x5, 64					// Yi
	mov x6, 112					// Xf
	mov x7, 256					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 272					// Xi
	mov x5, 160					// Yi
	mov x6, 288					// Xf
	mov x7, 480					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 112					// Xi
	mov x5, 64					// Yi
	mov x6, 240					// Xf
	mov x7, 80					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 240					// Xi
	mov x5, 48					// Yi
	mov x6, 256					// Xf
	mov x7, 144					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 336					// Xi
	mov x5, 16					// Yi
	mov x6, 352					// Xf
	mov x7, 112					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 272					// Xi
	mov x5, 48					// Yi
	mov x6, 288					// Xf
	mov x7, 144					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 256					// Xi
	mov x5, 128					// Yi
	mov x6, 272					// Xf
	mov x7, 144					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 304					// Xi
	mov x5, 48					// Yi
	mov x6, 320					// Xf
	mov x7, 144					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 112					// Xi
	mov x5, 96					// Yi
	mov x6, 192					// Xf
	mov x7, 112					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 336					// Xi
	mov x5, 128					// Yi
	mov x6, 496					// Xf
	mov x7, 144					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 368					// Xi
	mov x5, 96					// Yi
	mov x6, 480					// Xf
	mov x7, 112					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 368					// Xi
	mov x5, 48					// Yi
	mov x6, 384					// Xf
	mov x7, 96					// Yf
	bl Cuadrilatero       		// Pintamos la pared
	
	mov x4, 432					// Xi
	mov x5, 48					// Yi
	mov x6, 448					// Xf
	mov x7, 64					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 464					// Xi
	mov x5, 48					// Yi
	mov x6, 480					// Xf
	mov x7, 64					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 400					// Xi
	mov x5, 64					// Yi
	mov x6, 480					// Xf
	mov x7, 80					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 208					// Xi
	mov x5, 96					// Yi
	mov x6, 224					// Xf
	mov x7, 432					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 112					// Xi
	mov x5, 128					// Yi
	mov x6, 192					// Xf
	mov x7, 144					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 176					// Xi
	mov x5, 144					// Yi
	mov x6, 192					// Xf
	mov x7, 160					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 128					// Xi
	mov x5, 160					// Yi
	mov x6, 192					// Xf
	mov x7, 176					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 128					// Xi
	mov x5, 176					// Yi
	mov x6, 144					// Xf
	mov x7, 192					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 128					// Xi
	mov x5, 192					// Yi
	mov x6, 192					// Xf
	mov x7, 208					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 176					// Xi
	mov x5, 208					// Yi
	mov x6, 192					// Xf
	mov x7, 224					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 128					// Xi
	mov x5, 224					// Yi
	mov x6, 192					// Xf
	mov x7, 240					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 128					// Xi
	mov x5, 256					// Yi
	mov x6, 192					// Xf
	mov x7, 272					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 224					// Xi
	mov x5, 160					// Yi
	mov x6, 240					// Xf
	mov x7, 176					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 240					// Xi
	mov x5, 160					// Yi
	mov x6, 256					// Xf
	mov x7, 208					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 240					// Xi
	mov x5, 224					// Yi
	mov x6, 256					// Xf
	mov x7, 480					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 224					// Xi
	mov x5, 448					// Yi
	mov x6, 240					// Xf
	mov x7, 464					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 256					// Xi
	mov x5, 464					// Yi
	mov x6, 272					// Xf
	mov x7, 480					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 208					// Xi
	mov x5, 480					// Yi
	mov x6, 224					// Xf
	mov x7, 496					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 16					// Xi
	mov x5, 304					// Yi
	mov x6, 144					// Xf
	mov x7, 320					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 464					// Xi
	mov x5, 336					// Yi
	mov x6, 480					// Xf
	mov x7, 480					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 304					// Xi
	mov x5, 464					// Yi
	mov x6, 448					// Xf
	mov x7, 480					// Yf
	bl Cuadrilatero       		// Pintamos la pared
	
	mov x4, 304					// Xi
	mov x5, 432					// Yi
	mov x6, 416					// Xf
	mov x7, 448					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 304					// Xi
	mov x5, 448					// Yi
	mov x6, 320					// Xf
	mov x7, 464					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 368					// Xi
	mov x5, 288					// Yi
	mov x6, 384					// Xf
	mov x7, 304					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 368					// Xi
	mov x5, 304					// Yi
	mov x6, 416					// Xf
	mov x7, 320					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 400					// Xi
	mov x5, 288					// Yi
	mov x6, 448					// Xf
	mov x7, 304					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 432					// Xi
	mov x5, 304					// Yi
	mov x6, 480					// Xf
	mov x7, 320					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 464					// Xi
	mov x5, 272					// Yi
	mov x6, 480					// Xf
	mov x7, 304					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 464					// Xi
	mov x5, 192					// Yi
	mov x6, 480					// Xf
	mov x7, 240					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 432					// Xi
	mov x5, 160					// Yi
	mov x6, 448					// Xf
	mov x7, 240					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 448					// Xi
	mov x5, 224					// Yi
	mov x6, 464					// Xf
	mov x7, 240					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 448					// Xi
	mov x5, 160					// Yi
	mov x6, 496					// Xf
	mov x7, 176					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 304					// Xi
	mov x5, 160					// Yi
	mov x6, 416					// Xf
	mov x7, 176					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 304					// Xi
	mov x5, 176					// Yi
	mov x6, 320					// Xf
	mov x7, 192					// Yf
	bl Cuadrilatero       		// Pintamos la pared
	
	mov x4, 304					// Xi
	mov x5, 192					// Yi
	mov x6, 416					// Xf
	mov x7, 208					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 400					// Xi
	mov x5, 208					// Yi
	mov x6, 416					// Xf
	mov x7, 224					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 304					// Xi
	mov x5, 224					// Yi
	mov x6, 416					// Xf
	mov x7, 240					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 304					// Xi
	mov x5, 240					// Yi
	mov x6, 320					// Xf
	mov x7, 336					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 304					// Xi
	mov x5, 352					// Yi
	mov x6, 320					// Xf
	mov x7, 416					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 320					// Xi
	mov x5, 400					// Yi
	mov x6, 432					// Xf
	mov x7, 416					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 432					// Xi
	mov x5, 400					// Yi
	mov x6, 448					// Xf
	mov x7, 464					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 336					// Xi
	mov x5, 240					// Yi
	mov x6, 352					// Xf
	mov x7, 384					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 352					// Xi
	mov x5, 256					// Yi
	mov x6, 480					// Xf
	mov x7, 272					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 352					// Xi
	mov x5, 336					// Yi
	mov x6, 464					// Xf
	mov x7, 352					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 352					// Xi
	mov x5, 368					// Yi
	mov x6, 448					// Xf
	mov x7, 384					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 416					// Xi
	mov x5, 384					// Yi
	mov x6, 432					// Xf
	mov x7, 400					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 160					// Xi
	mov x5, 288					// Yi
	mov x6, 192					// Xf
	mov x7, 304					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 176					// Xi
	mov x5, 304					// Yi
	mov x6, 192					// Xf
	mov x7, 352					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 128					// Xi
	mov x5, 320					// Yi
	mov x6, 176					// Xf
	mov x7, 336					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 176					// Xi
	mov x5, 368					// Yi
	mov x6, 192					// Xf
	mov x7, 432					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 192					// Xi
	mov x5, 416					// Yi
	mov x6, 208					// Xf
	mov x7, 432					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 32					// Xi
	mov x5, 320					// Yi
	mov x6, 48					// Xf
	mov x7, 368					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 32					// Xi
	mov x5, 384					// Yi
	mov x6, 48					// Xf
	mov x7, 480					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 64					// Xi
	mov x5, 336					// Yi
	mov x6, 80					// Xf
	mov x7, 448					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 48					// Xi
	mov x5, 432					// Yi
	mov x6, 64					// Xf
	mov x7, 448					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 64					// Xi
	mov x5, 464					// Yi
	mov x6, 112					// Xf
	mov x7, 480					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 96					// Xi
	mov x5, 480					// Yi
	mov x6, 112					// Xf
	mov x7, 496					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 96					// Xi
	mov x5, 448					// Yi
	mov x6, 144					// Xf
	mov x7, 464					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 128					// Xi
	mov x5, 464					// Yi
	mov x6, 192					// Xf
	mov x7, 480					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 176					// Xi
	mov x5, 448					// Yi
	mov x6, 208					// Xf
	mov x7, 464					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 96					// Xi
	mov x5, 320					// Yi
	mov x6, 112					// Xf
	mov x7, 368					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 144					// Xi
	mov x5, 352					// Yi
	mov x6, 160					// Xf
	mov x7, 432					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 112					// Xi
	mov x5, 352					// Yi
	mov x6, 128					// Xf
	mov x7, 368					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 80					// Xi
	mov x5, 384					// Yi
	mov x6, 128					// Xf
	mov x7, 400					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 96					// Xi
	mov x5, 400					// Yi
	mov x6, 112					// Xf
	mov x7, 416					// Yf
	bl Cuadrilatero       		// Pintamos la pared

	mov x4, 96					// Xi
	mov x5, 416					// Yi
	mov x6, 144					// Xf
	mov x7, 432					// Yf
	bl Cuadrilatero       		// Pintamos la pared

PonerMinas:
	mov x4, 192
	mov x5, 16
	bl DibujarMina

	mov x4, 208
	mov x5, 80
	bl DibujarMina

	mov x4, 224
	mov x5, 224
	bl DibujarMina

	mov x4, 48
	mov x5, 400
	bl DibujarMina

	mov x4, 288
	mov x5, 224
	bl DibujarMina
	
	mov x4, 336
	mov x5, 448
	bl DibujarMina

	mov x4, 160
	mov x5, 304
	bl DibujarMina

	mov x4, 144
	mov x5, 208
	bl DibujarMina

	mov x4, 448
	mov x5, 192
	bl DibujarMina

	mov x4, 416
	mov x5, 48
	bl DibujarMina

	mov x4, 112
	mov x5, 464
	bl DibujarMina
	
	mov x4, 384
	mov x5, 288
	bl DibujarMina

//------------------------------------------------------- JUEGO DINÁMICO ---------------------------------------------------------//

GenerarPacmanInicio:
	mov x4, 0
	mov x5, 288
	mov x6, 16
	mov x7, 304
	bl DibujarPacman
	mov x18, 0					// Esto setea mi Xi = 0
	mov x19, 288				// Esto setea mi Yi = 288

jugar:

LeerInputs:
	bl inputRead        		//una vez dibujado el personaje consulto si alguno de los botones esta presionado
	cbnz x22, MoverAbajo     	//consulto por boton abajo
	cbnz x23, MoverIzquierda  	//consulto por boton izquierda
	cbnz x24, MoverDerecha    	//consulto por boton derecha
	cbnz x25, MoverArriba		//consulto por boton arriba

	b delay2
	b jugar

MoverAbajo:
	add x10, x0, 0	    		// X10 contiene la dirección base del framebuffer
	mov x16, 1024       		// Auxiliar 
	mov x17, 2          		// Auxiliar
	mul x9, x19, x16     		// X9 = Yi * 1024
	mul x14, x18, x17    		// x14 = 2 * Xi
	add x9, x9, x14	   			// x9 = 2 * Xo + (Yo * 1024)
	add x10, x10, x9    		// x10 = x0 + 2 * Xo + (Yo * 1024)
	ldurh w3, [x10]				// Guardo el color del fondo actual
	
	mov x15, 16					// Auxiliar
	mul x15, x15, x16
	add x10, x10, x15			// Obtengo el 16vo pixel que sigue 
	ldurh w13, [x10]			// Guardo en w13, el color de esa casilla.
	mov w27, 0xF810
	cmp w13, w27				// Comparo el color con fucsia.
	b.eq delay2					// Si es pared que no lo deje avanzar.
	mov x4, x18					// Asigno mi Xo
	mov x5, x19					// Asigno mi Yo
	add x6, x4, 16				// Asigno mi Xf
	add x7, x5, 16				// Asigno mi Yf
	bl Cuadrilatero				// Pinto el fondo actual del color actual (Borro el Pacman)

	add x19, x19, 16			// Yi++
	mov x4, x18					// Xo = Xi 
	mov x5, x19					// Yo = Yi
	add x6, x4, 16				// Xf = Xi + 16
	add x7, x5, 16				// Yf = Yi + 16
	cmp w13, 0X0000				// Sí es el fondo de la mina, que lo mande a perder
	b.eq Perder					// Sí es de color del borde de la mina, PintarParedes
	cmp w13, 0x0400				// Si el fondo es verde es por que ganó
	b.eq Ganar
	bl DibujarPacman

	b delay2

MoverIzquierda:
	add x10, x0, 0	    		// X10 contiene la dirección base del framebuffer
	mov x16, 1024       		// Auxiliar 
	mov x17, 2          		// Auxiliar
	mul x9, x19, x16     		// X9 = Yi * 1024
	mul x14, x18, x17    		// x14 = 2 * Xi
	add x9, x9, x14	   			// x9 = 2 * Xo + (Yo * 1024)
	add x10, x10, x9    		// x10 = x0 + 2 * Xo + (Yo * 1024)
	ldurh w3, [x10]				// Guardo el color del fondo actual
	sub x10, x10, 32			// Retrocedo de pixel

	ldurh w13, [x10]			// Guardo en w13, el color de esa casilla.
	mov w27, 0xF810
	cmp w13, w27				// Comparo el color con fucsia.
	b.eq delay2					// Si es pared que no lo deje moverse.
	mov x4, x18					// Asigno mi Xo
	mov x5, x19					// Asigno mi Yo
	add x6, x4, 16				// Asigno mi Xf
	add x7, x5, 16				// Asigno mi Yf
	bl Cuadrilatero				// Pinto el fondo actual del color actual (Borro el Pacman)

	sub x18, x18, 16			// Xi--
	mov x4, x18					// Xo = Xi 
	mov x5, x19					// Yo = Yi
	add x6, x4, 16				// Xf = Xi + 16
	add x7, x5, 16				// Yf = Yi + 16
	cmp w13, 0X0000				// Sí es el fondo de la mina, que lo mande a perder
	b.eq Perder					// Sí es de color del borde de la mina, PintarParedes
	cmp w13, 0x0400				// Si el fondo es verde es por que ganó
	b.eq Ganar
	bl DibujarPacman
	b delay2

MoverDerecha:
	// x1, x2 son auxiliares
	add x10, x0, 0	    		// X10 contiene la dirección base del framebuffer
	mov x16, 1024       		// Auxiliar 
	mov x17, 2          		// Auxiliar
	mul x9, x19, x16     		// X9 = Yi * 1024
	mul x14, x18, x17    		// x14 = 2 * Xi
	add x9, x9, x14	   			// x9 = 2 * Xi + (Yi * 1024)
	add x10, x10, x9    		// x10 = x0 + 2 * Xi + (Yi * 1024)
	ldurh w3, [x10]				// Guardo el color del fondo actual

	add x10, x10, 32			// Obtengo el 16vo pixel que sigue 
	ldurh w13, [x10]			// Guardo en w13, el color de esa casilla.
	mov w27, 0xF810
	cmp w13, w27				// Comparo el color con fucsia.
	b.eq delay2					// Si es pared que no lo deje moverse.
	mov x4, x18					// Asigno mi Xo
	mov x5, x19					// Asigno mi Yo
	add x6, x4, 16				// Asigno mi Xf
	add x7, x5, 16				// Asigno mi Yf
	bl Cuadrilatero				// Pinto el fondo actual del color actual (Borro el Pacman)

	add x18, x18, 16			// Xi++
	mov x4, x18					// Xo = Xi 
	mov x5, x19					// Yo = Yi
	add x6, x4, 16				// Xf = Xi + 16
	add x7, x5, 16				// Yf = Yi + 16
	cmp w13, 0X0000				// Sí es el fondo de la mina, que lo mande a perder
	b.eq Perder					// Sí es de color del borde de la mina, PintarParedes
	cmp w13, 0x0400				// Si el fondo es verde es por que ganó
	b.eq Ganar
	bl DibujarPacman

	b delay2

MoverArriba:
	add x10, x0, 0	    		// X10 contiene la dirección base del framebuffer
	mov x16, 1024       		// Auxiliar 
	mov x17, 2          		// Auxiliar
	mul x9, x19, x16     		// X9 = Yi * 1024
	mul x14, x18, x17    		// x14 = 2 * Xi
	add x9, x9, x14	   			// x9 = 2 * Xo + (Yo * 1024)
	add x10, x10, x9    		// x10 = x0 + 2 * Xo + (Yo * 1024)
	ldurh w3, [x10]				// Guardo el color del fondo actual

	mov x15, 16					// Auxiliar
	mul x15, x15, x16
	sub x10, x10, x15			// Obtengo el pixel que sigue 
	ldurh w13, [x10]			// Guardo en w13, el color de esa casilla.
	mov w27, 0xF810
	cmp w13, w27				// Comparo el color con fucsia.
	b.eq delay2					// Si es pared que no lo deje moverse.

	mov x4, x18					// Asigno mi Xo
	mov x5, x19					// Asigno mi Yo
	add x6, x4, 16				// Asigno mi Xf
	add x7, x5, 16				// Asigno mi Yf
	bl Cuadrilatero				// Pinto el fondo actual del color actual (Borro el Pacman)

	sub x19, x19, 16			// Yi--
	mov x4, x18					// Xo = Xi 
	mov x5, x19					// Yo = Yi
	add x6, x4, 16				// Xf = Xi + 16
	add x7, x5, 16				// Yf = Yi + 16
	cmp w13, 0X0000				// Sí es el fondo de la mina, que lo mande a perder
	b.eq Perder					// Sí es de color del borde de la mina, PintarParedes
	cmp w13, 0x0400				// Si el fondo es verde es por que ganó
	b.eq Ganar
	bl DibujarPacman
	b delay2

Perder:
	mov w26, 0x8				// Esto selecciona el GPIO 3 (Rojo)
	bl PrenderLed				// Se prende
	sub x4, x18, 16				// Xo = Xi - 16
	sub x5, x19, 16				// Yo = Yi - 16
	add x6, x18, 32				// Xf = Xi + 32
	add x7, x19, 32				// Yf = Yi + 32
	mov w3, 0x0821
	bl Cuadrilatero

	mov x4, x18					// Xo = Xi 
	mov x5, x19					// Yo = Yi
	add x6, x4, 16				// Xf = Xi + 16
	add x7, x5, 16				// Yf = Yi + 16
	bl DibujarPacmanMuerto

InfinitoP:
	b InfinitoP

Ganar:
	bl DibujarPacman
	mov w26, 0x4				// Esto selecciona el GPIO 2 (verde)
	bl PrenderLed				// Se prende

InfinitoG:
	b InfinitoG

//----------------------------------------------------- GLOSARIO DE REGISTROS ------------------------------------------------------//

// x0: 	Es el registro que contiene la dirección base del framebuffer
// x1:	Es el contador de X
// x2:	Es el contador de Y
// w3:	Color del FrameBuffer
// x4:	Es el registro que contiene el Xo de inicio del rectángulo
// x5:	Es el registro que contiene el Yo de inicio del rectángulo
// x6:	Es el registro que contiene el Xf de inicio del rectángulo
// x7:	Es el registro que contiene el Yf de inicio del rectángulo
// x8:	Va a ser el Yi
// x9:	Va a ser el Xi
// x10: Es el registro que contiene la dirección en la que se va a pintar
// x11:	Es el registro que tiene el límite.
// x12: Es el registro de los Delays
// x13: 
// x14: Yi de la función Cuadrilatero
// x15: Auxiliar Genérico
// x16: Auxiliar que guarda 512 o 1024 dependiendo el contexto
// x17: Tiene guardado un 2
// x18: 
// x19:  
// w20:	Es la dirección del GPIO, no borrar
// w21: Es el registro que usamos para comunicarnos con el GPIO_GPFSEL1
// w22:	Es para el GPIO 17
// w23:	Es para el GPIO 18
// w24:	Es para el GPIO 15
// w25:	Es para el GPIO 14
// w26: Es para las Leds
// x30:	Es el registro del Link register

// GPIO14 = arriba
// GPIO17 = abajo
// GPIO18 = izquierda 
// GPIO15 = derecha 
// GPIO3 = led rojo
// GPIO2 = led verde

//----------------------------------------------------- FUNCIONES ------------------------------------------------------------//

Cuadrilatero:
iteracion2:
	add x10, x0, 0	    		// X10 contiene la dirección base del framebuffer
	mov x16, 1024       		// Auxiliar 
	mov x17, 2          		// Auxiliar
	mul x9, x5, x16     		// X9 = Yo * 1024
	mul x14, x4, x17    		// x14 = 2 * Xo
	add x9, x9, x14	   			// x9 = 2 * Xo + (Yo * 1024)
	add x10, x10, x9    		// x10 = x0 + 2 * Xo + (Yo * 1024)
	add x14, x5, 0				// x14 = Yo
RP1:
	add x9, x4, 0    			// X = xo
RP0:
	sturh w3, [x10]	   			// Pinto
	add x10, x10, 2	   			// Paso al siguiente pixel
	add x9, x9, 1	   			// X--
	cmp x9, x6               	// Xi - Xf
	b.ne RP0					// Si Xi != Xf, entonces pasa a repetirse
	add x14, x14, 1	   			// Yi ++
	sub x15, x6, x4		
	mul x15, x15, x17	
	sub x15, x16, x15	
	add x10, x10, x15     
	cmp x14, x7
	b.ne RP1	  	
	br x30 	

DibujarMina:
// Esta parte va a pintar de negro la casilla del fondo de la mina
	add x10, x0, xzr			// Reseteo la dirección base del x10
	mov x16, 512				// x16 = 512
	mov x17, 2					// x17 = 2
	mul x8, x5, x16				// x8 = Yo * 512
	add x8, x4, x8				// x8 = Xo + (Yo * 512)
	mul x8, x17, x8				// x8 = 2 * (Xo + (Yo * 512))
	add x10, x10, x8			// x10 = x0 + 2 * (Xo + (Yo * 512))  -> Fórmula del enunciado
	mov x2, 16					// x2 = contador de Y = 16
	mov w3, 0x0000
DMN1:
	mov x1, 16					// x1 = contador X = 16
DMN0:
	sturh w3, [x10]			// cargo el color negro
	add x10, x10, 2				// Paso al siguiente pixel
	sub x1, x1, 1				// X--
	cbnz x1, DMN0				// Si x != 0 pasa a repetirse
	sub x2, x2, 1				// Y--
	add x10, x10, 992			// Estoy avanzando los 496 pixeles (empezar en la fila de abajo)
	cbnz x2, DMN1				// si Y != 0 pasa a repetirse.
// Esta parte va a pintar de gris claro la mina
	add x10, x0, x8				// x10 = x0 + 2 * (Xo + (Yo * 512))  -> Fórmula del enunciado
	add x10, x10, 12			// Desplazo a x10 unos 6 pixeles para que dibuje bien
	mov x2, 6					// x2 = contador de Y = 6
	mov w3, 0xBD76				// Pone a w3 de gris claro
DMGC1:
	mov x1, 4					// x1 = contador de X = 4  (es por la forma de la mina)
	mov x15, 6					// x15 = 6
	sub x15, x15, x2			// x15 = 6 - Y
	add x15, x15, x15			// x15 = 2 * (6 - Y)
	add x1, x1, x15				// x1 = contador de X = 4 + 2 * (6 - Y)
	mov x16, 511				// x16 = número de pixeles por línea - 1
	sub x16, x16, x1			// x16 = números de pixeles restantes para pasar a la siguiente línea
	add x16, x16, x16			// x16 = cantidad de bytes que sumo para llegar a ese pixel que quiero.
DMGC0:
	sturh w3, [x10]				// cargo el color negro
	add x10, x10, 2				// Paso al siguiente pixel
	sub x1, x1, 1				// X--
	cbnz x1, DMGC0				// Si x != 0 pasa a repetirse
	sub x2, x2, 1				// Y--
	add x10, x10, x16			// Aca paso a la siguiente fila
	cbnz x2, DMGC1				// Si Y != 0 pasa a repetirse
// Aca simplemente calculamos cuatro líneas fijas
	//add x10, x10, 996			// aca pasamos a la dirección que corresponde
	mov x2, 4					// Contador de Y = 4
DMGC3:
	mov x1, 16					// Contador de X = 16
DMGC2:
	sturh w3, [x10]			// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sub x1, x1, 1				// X--
	cbnz x1, DMGC2				// Si x != 0 pasa a repetirse
	SUB X2, X2, 1				// Y--
	add x10, x10, 992			// Paso a la siguiente fila
	cbnz x2, DMGC3				// Si Y != 0 pasa a repetirse
// Aca pintamos el rombo para abajo
	add x10, x10, 2				// Paso al siguiente pixel
	mov x2, 6					// x2 = contador de Y = 6
DMGC5:
	mov x1, 4					// x1 = contador de X = 4  (es por la forma de la mina)
	sub x15, x2, 1				// x15 = (Y - 1)
	add x15, x15, x15			// x15 = 2 * (Y - 1)
	add x1, x1, x15				// X = 4 + 2 * (Y - 1)
	mov x16, 513				// x16 = número de pixeles por línea + 1
	sub x16, x16, x1			// x16 = números de pixeles restantes para pasar a la siguiente línea
	add x16, x16, x16			// x16 = cantidad de bytes que sumo para llegar a ese pixel que quiero.
DMGC4:
	sturh w3, [x10]			// cargo el color negro
	add x10, x10, 2				// Paso al siguiente pixel
	sub x1, x1, 1				// X--
	cbnz x1, DMGC4				// Si x != 0 pasa a repetirse
	sub x2, x2, 1				// Y--
	add x10, x10, x16			// Aca paso a la siguiente fila
	cbnz x2, DMGC5				// Si Y != 0 pasa a repetirse
//Esta parte pinta la mina de Gris Oscuro
	mov w3, 0x2104				// gris
	add x10, x0, x8				// x10 = x0 + 2 * (Xo + (Yo * 512))  -> Fórmula del enunciado
	add x10, x10, 12			// Avanzo 6 pixeles
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1014			// Paso a la línea 2
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso a la siguiente franja
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1006			// Paso a la línea 3
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso a la siguiente franja
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso a la siguiente franja
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso a la siguiente franja
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1002			// Paso a la línea 4
	sturh w3, [x10]				// Pinto
	add x10, x10, 8				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 8				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1000			// Paso a la línea 5
	sturh w3, [x10]				// Pinto
	add x10, x10, 8				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 10			// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 8				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 998			// Paso a la línea 6
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 996			// Paso a la línea 7
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 994			// Paso a la línea 8
	sturh w3, [x10]				// Pinto
	add x10, x10, 10			// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 10			// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 10			// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 994			// Paso a la línea 9
	sturh w3, [x10]				// Pinto
	add x10, x10, 10			// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 10			// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 10			// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 994			// Paso a la línea 10
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 996			// Paso a la línea 11 
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 998			// Paso a la línea 12
	sturh w3, [x10]				// Pinto
	add x10, x10, 8				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 10			// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 8				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1000			// Paso a la línea 13
	sturh w3, [x10]				// Pinto
	add x10, x10, 8				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 8				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1002			// Paso a la línea 14
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso a la siguiente franja
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso a la siguiente franja
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso a la siguiente franja
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1006			// Paso a la línea 15
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 6				// Paso a la siguiente franja
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1014			// Paso a la Línea 16
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
//Esta parte pinta la mina de Rojo
	mov w3, 0xFE18				// Rojo clarito
	add x10, x0, x8				// Asigno la dirección del primer pixel de la mina
	add x10, x10, 3079			// Paso al primer pixel de Rojo
	add x10, x10, 3079			// Paso al primer pixel de Rojo
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0xF800				// Asigno el color rojo al registro w3
	sturh w3, [x10]				// Pinto
	add x10, x10, 1020			// Aca simplemente paso a la siguiente fila
	mov w3, 0xFE18				// Rojo clarito
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	mov w3, 0xF800				// Asigno el color rojo al registro w3
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1018			// Aca simplemente paso a la siguiente fila
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1020			// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	br x30

DibujarPacman:
	// Le tengo que pasar el Xo, el Yo 
	add x10, x0, xzr			// Reseteo la dirección base del x10
	mov x16, 512				// x16 = 512
	mov x17, 2					// x17 = 2
	mul x8, x5, x16				// x8 = Yo * 512
	add x8, x4, x8				// x8 = Xo + (Yo * 512)
	mul x8, x17, x8				// x8 = 2 * (Xo + (Yo * 512))
	add x10, x10, x8			// x10 = x0 + 2 * (Xo + (Yo * 512))  -> Fórmula del enunciado
	add x10, x10, 1024			// La primera fila no se pinta
	add x10, x10, 12			// Paso 6 pixeles y Pinto
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1012			// Paso a la línea 3
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0xFFE0				// Pongo el color amarillo
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1006			// Paso a la Línea 4
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0xFFE0				// Pongo el color amarillo
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 1002			// Paso a la Línea 5
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFE0				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color de los ojos
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0xFFFF				// Pongo el color de los ojos
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0xFFE0				// Pongo el color amarillo
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 1000			// Paso a la Línea 6
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFE0				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color de los ojos
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFE0				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 998			// Paso a la Línea 7
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFE0				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto	
	add x10, x10, 1000			// Paso a la Línea 8
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFE0				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1004			// Paso a la Línea 9
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFE0				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1010			// Paso a la Línea 10
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFE0				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1004			// Paso a la Línea 11
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFE0				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto	
	add x10, x10, 1002			// Paso a la Línea 12
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFE0				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 1000			// Paso a la Línea 13
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFE0				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 1002			// Paso a la Línea 14
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0xFFE0				// Pongo el color amarillo
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 1006			// Paso a la Línea 15
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0xFFE0				// Pongo el color amarillo
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1012			// Paso a la Línea 16
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	br x30

DibujarPacmanMuerto:
	// Le tengo que pasar el Xo, el Yo 
	add x10, x0, xzr			// Reseteo la dirección base del x10
	mov x16, 512				// x16 = 512
	mov x17, 2					// x17 = 2
	mul x8, x5, x16				// x8 = Yo * 512
	add x8, x4, x8				// x8 = Xo + (Yo * 512)
	mul x8, x17, x8				// x8 = 2 * (Xo + (Yo * 512))
	add x10, x10, x8			// x10 = x0 + 2 * (Xo + (Yo * 512))  -> Fórmula del enunciado
	add x10, x10, 1024			// La primera fila no se pinta
	add x10, x10, 12			// Paso 6 pixeles y Pinto
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1012			// Paso a la línea 3
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0xFFFF				// Pongo el color amarillo
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1006			// Paso a la Línea 4
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0xFFFF				// Pongo el color amarillo
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 1002			// Paso a la Línea 5
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFFF				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color de los ojos
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0xFFFF				// Pongo el color de los ojos
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0xFFFF				// Pongo el color amarillo
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 1000			// Paso a la Línea 6
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFFF				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color de los ojos
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFFF				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 998			// Paso a la Línea 7
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFFF				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto	
	add x10, x10, 1000			// Paso a la Línea 8
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFFF				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1004			// Paso a la Línea 9
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFFF				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1010			// Paso a la Línea 10
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFFF				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1004			// Paso a la Línea 11
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFFF				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto	
	add x10, x10, 1002			// Paso a la Línea 12
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFFF				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 1000			// Paso a la Línea 13
	sturh w3, [x10]				// Pinto
	mov w3, 0xFFFF				// Pongo el color amarillo
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 1002			// Paso a la Línea 14
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0xFFFF				// Pongo el color amarillo
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 1006			// Paso a la Línea 15
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0xFFFF				// Pongo el color amarillo
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	mov w3, 0x0000				// Pongo el color del borde
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 1012			// Paso a la Línea 16
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sturh w3, [x10]				// Pinto
	br x30

//-------------------------------------------------------- DELAY --------------------------------------------------------------//
		
delay2:
	// --- Delay loop ---
	movz x12, 0x0C, lsl 16		// Tiempo de delay, capaz debería probar con 0x8
delay1: 
	sub x12, x12, 1
	cbnz x12, delay1
	// ------------------
				
	b jugar    
	// Vuelvo a "Jugar" después de hacer el delay (para que lo persiva el ojo humano).
    