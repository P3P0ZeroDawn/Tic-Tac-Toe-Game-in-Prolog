
%%% Extrae elementos de la lista de 9%%%5
extraer_elem(Lista,A,B,C,D,E,F,G,H,I):-
         elem_lista(Lista,1,A),
         elem_lista(Lista,2,B),
         elem_lista(Lista,3,C),
         elem_lista(Lista,4,D),
         elem_lista(Lista,5,E),
         elem_lista(Lista,6,F),
         elem_lista(Lista,7,G),
         elem_lista(Lista,8,H),
         elem_lista(Lista,9,I).

%%% IMPRIMIR TABLERO

imprimir_tablero(Lista):- 
                      extraer_elem(Lista,A,B,C,D,E,F,G,H,I), nl,
		      write("     |     |     "), nl,
		      write("  "), write(A), write("  |  "), write(B), write("  |  "), write(C), write("  "), nl,
		      write("_____|_____|_____"), nl,
                      write("     |     |     "), nl,
		      write("  "), write(D), write("  |  "), write(E), write("  |  "), write(F), write("  "), nl,
                      write("_____|_____|_____"), nl,
		      write("     |     |     "), nl,
                      write("  "), write(G), write("  |  "), write(H), write("  |  "), write(I), write("  "), nl,
	              write("     |     |     "), nl, nl.


%%% comprobar si la lista aun no esta llena %%%
no_llena([A|_]):- A=:=" ".
no_llena([_|Y]):-no_llena(Y).

%%%% comprobacion de ganador  %%%%
gana(A,A,A):- A=:="X", write("El ganador es X"), nl.   %% checa que los 3 elementos sean iguales a "X"
gana(A,A,A):- A=:="O", write("El ganador es O"), nl.      %% lo mismo pero con "O" 


%% Extrae los elementos de la lista y checa si ocurre algun caso
ganador(Lista):- extraer_elem(Lista,A,B,C,D,E,F,G,H,I), 
                  (gana(A,B,C); gana(D,E,F); gana(G,H,I);
                   gana(A,D,G); gana(B,E,H); gana(C,F,I); 
                   gana(A,E,I); gana(C,E,G)).

%%% Empate
empate():-nl, write("	"), write("Empate"), nl, write("Escribe jugar(). para volver a intentarlo").  % no checa nada, solo es una condicion de ultima instancia


%%% ELEMENTO EN POSICION K 

elem_lista([Elemento|_], 1, Elemento). %caso base, el resultado es la cabeza de la lista cuando el contador llegue a 1
elem_lista([_|Y], Posicion, Elemento):- X1 is Posicion - 1, elem_lista(Y, X1, Elemento). % caso recursivo, recorre la lista y va decrementando el contador hasta llegar al caso base

%%%% GENERADOR LINEAL CONGRUENTE %%%%
%forma de generar valores numericos pseudoaleatorios, recibe una semilla, hace operaciones con ella y genera un resultado y una nueva semilla, si se vuelve a llamar la nueva semilla se ocupa como semilla
aleatorio(Semilla, Aleatorio, NuevaSemilla):-
	A is 1103515245, % Constante multiplicadora
	C is 12345,   % Constante sumadora
	M is 2147483648,    % Modulo
	NuevaSemilla is (A * Semilla + C) mod M, % Calculo de la siguiente semilla
	Aleatorio is 1 + (NuevaSemilla mod 9).   %%% Mover un valor adelante ya que el modulo 9 puede dar desde 0 hasta 8

%%% INGRESAR VALORES DE USUARIO

esta_vacia(Pos, Lista):- elem_lista(Lista, Pos, Casilla), Casilla=:=" ". % permite comprobar si una posicion esta vacia

ingresa(1, D, [" "|Y], [D|Y]). %caso base para ingresar datos, la posicion tiene valor 1 y el elemento se inserta en la cabeza de la lista

ingresa(Pos, Elem, [X|Y], [X|Z]):- Pos1 is Pos -1, ingresa(Pos1, Elem, Y, Z). %caso recursivo, va recorriendo la lista y decrementando el contador de posicion

%%% MODO DE DOS JUGADORES

turno(Lista, D, Lista1):- write("Ingresa la posicion a jugar: "),
			  read(Pos), % se lee la entrada del usuario
			(
			  (Pos > 9; Pos < 1) ->
		          (write("Posicion invalida, debe estar en el rango del 1 al 9"), nl, turno(Lista, D, Lista1)) %validamos para no salirnos del rango
			  ;
			  (esta_vacia(Pos, Lista) ->
		          ingresa(Pos, D, Lista, Lista1) %comprobamos que la posicion indicada en la entrada esta vacia y si es asi, se ingresa el valor
			  ;
			  (writeln("Esa casilla ya esta ocupada o no es valida, intenta otra vez"), turno(Lista, D, Lista1)) %si no se cumple nada de lo anterior, la entrada fue incorrecta, se llama otra vez la regla
			  )
			).

gato(Lista):- no_llena(Lista), turno(Lista, "X", Lista1), imprimir_tablero(Lista1), (ganador(Lista1); gato_segundo(Lista1); empate()). %regla que lleva el funcionamiento principal del juego para dos jugadores, comprueba que no se haya llenado la lista, llama al turno para la entrada del usuario, imprime el tablero con la lista actualizada y luego comprueba si hay ganador, si no hay entonces llama a la regla del segundo jugador, si ya no puede llamarla porque la lista se lleno, entonces hay empate

gato_segundo(Lista):- no_llena(Lista), turno(Lista, "O", Lista1), imprimir_tablero(Lista1), (ganador(Lista1); gato(Lista1); empate()). %regla que lleva el funcionamiento secundario del juego para dos jugadores, hace lo mismo que la anterior con la diferencia de que esta ingresa O en vez de X

analizar_tablero(Lista, Elemento, Posicion):-          %esta regla permite analizar todas las posibles combinaciones del tablero en las cuales uno de los jugadores podria ganar o perder, unifica la primera posicion vacia de un trio que tiene dos elementos iguales y uno vacio 
    extraer_elem(Lista, A, B, C, D, E, F, G, H, I),
    (
        (A = " ", B = Elemento, C = Elemento -> Posicion is 1)
        ;
        (A = Elemento, B = " ", C = Elemento -> Posicion is 2)
        ;
        (A = Elemento, B = Elemento, C = " " -> Posicion is 3)
        ;
        (D = " ", E = Elemento, F = Elemento -> Posicion is 4)
        ;
        (D = Elemento, E = " ", F = Elemento -> Posicion is 5)
        ;
        (D = Elemento, E = Elemento, F = " " -> Posicion is 6)
        ;
        (G = " ", H = Elemento, I = Elemento -> Posicion is 7)
        ;
        (G = Elemento, H = " ", I = Elemento -> Posicion is 8)
        ;
        (G = Elemento, H = Elemento, I = " " -> Posicion is 9)
        ;
        (A = " ", D = Elemento, G = Elemento -> Posicion is 1)
        ;
        (A = Elemento, D = " ", G = Elemento -> Posicion is 4)
        ;
        (A = Elemento, D = Elemento, G = " " -> Posicion is 7)
        ;
        (B = " ", E = Elemento, H = Elemento -> Posicion is 2)
        ;
        (B = Elemento, E = " ", H = Elemento -> Posicion is 5)
        ;
        (B = Elemento, E = Elemento, H = " " -> Posicion is 8)
        ;
        (C = " ", F = Elemento, I = Elemento -> Posicion is 3)
        ;
        (C = Elemento, F = " ", I = Elemento -> Posicion is 6)
        ;
        (C = Elemento, F = Elemento, I = " " -> Posicion is 9)
        ;
        (A = " ", E = Elemento, I = Elemento -> Posicion is 1)
        ;
        (A = Elemento, E = " ", I = Elemento -> Posicion is 5)
        ;
        (A = Elemento, E = Elemento, I = " " -> Posicion is 9)
        ;
        (C = " ", E = Elemento, G = Elemento -> Posicion is 3)
        ;
        (C = Elemento, E = " ", G = Elemento -> Posicion is 5)
        ;
        (C = Elemento, E = Elemento, G = " " -> Posicion is 7)
    ).

%%% JUEGO OFENSIVO

juego_ofensivo(Lista, Lista1):- analizar_tablero(Lista, "O", Posicion), ingresa(Posicion, "O", Lista, Lista1). %la maquina analiza el tablero buscando posiciones donde puede ganar, ya que busca trios donde este la O dos veces y el tercer elemento este vacio, juega en el primero que encuentra

%%% JUEGO DEFENSIVO

juego_defensivo(Lista, Lista1):- analizar_tablero(Lista, "X", Posicion), ingresa(Posicion, "O", Lista, Lista1). %la maquina analiza el tablero buscando posiciones donde pueda perder, ya que busca trios donde este la X dos veces y el tercer elemento este vacio. juega O en el primero que encuentre

%%% JUEGA ESTRATEGIA

juego_estrategia(Lista, Lista1):- % para el modo avanzado, aumenta un poco mas el nivel de dificultad
	extraer_elem(Lista, A, _, C, _, E, _, G, _, I), % se ignoran elementos que no vamos a utilizar
        (
	 (((A \= " "); (C \= " "); (G \=" "); (I \= " ")) -> % comprueba si se jugo en alguna esquina
	 ((E = " ") -> ingresa(5, "O", Lista, Lista1)))  % si efectivamente se jugo en alguna esquina entonces se juega en el centro, ya que el centro participa en una mayor cantidad de victorias que cualquier otra posicion
	 ;
	 ((A = " ") -> 
	 ingresa(1, "O", Lista, Lista1)) % el resto de lineas de esta regla comprueban la disponibilidad de jugar en las esquinas y juegan en ellas, lo que da un mayor margen de victoria a la maquina
	 ;
	 ((C = " ") -> 
	 ingresa(3, "O", Lista, Lista1))
	 ;
	 ((G = " ") -> 
	 ingresa(7, "O", Lista, Lista1))
	 ;
	 ((I = " ") -> 
	 ingresa(9, "O", Lista, Lista1))
	).

     
%%% TURNO DE LA COMPU BASICO

turno_compu_basico(Lista, D, Lista1, Semilla):- % modo basico o facil de la maquina, juega a ganar, si no puede entonces se defiende, si no puede ninguna entonces juega aleatorio
    aleatorio(Semilla, Aleatorio, NuevaSemilla), % generamos un valor aleatorio para la posicion a jugar
    (
        juego_ofensivo(Lista, Lista1), write("La computadora jugo: "), nl
        ;
        juego_defensivo(Lista, Lista1), write("La computadora jugo: "), nl
        ;
        (esta_vacia(Aleatorio, Lista) ->  % llamar a ingresar en posiciones generadas aleatoriamente puede conducir a intentar ingresar en posiciones ya ocupadas, necesitamos validarlas
            write("La computadora jugo: "), nl,
            ingresa(Aleatorio, D, Lista, Lista1)
        ;
            turno_compu_basico(Lista, D, Lista1, NuevaSemilla))  % si la entrada fue invalida entonces se llama otra vez esta regla hasta que se encuentre un valor valido
    ).

%%% TURNO DE LA COMPU AVANZADO

turno_compu_avanzado(Lista, D, Lista1, Semilla):- % modo avanzado o difil de la maquina, juega a ganar, si no puede entonces se defiende, si no puede ninguna entonces aplica la estrategia del centro y las esquinas, si no puede entonces juega aleatorio
    aleatorio(Semilla, Aleatorio, NuevaSemilla), % generamos un valor aleatorio para la posicion a jugar
    (
        juego_ofensivo(Lista, Lista1), write("La computadora jugo: "), nl
        ;
        juego_defensivo(Lista, Lista1), write("La computadora jugo: "), nl
        ;
	juego_estrategia(Lista, Lista1), write("La computadora jugo: "), nl
        ;
        (esta_vacia(Aleatorio, Lista) -> % misma validacion del anterior
            write("La computadora jugo: "), nl,
            ingresa(Aleatorio, D, Lista, Lista1)
        ;
            turno_compu_avanzado(Lista, D, Lista1, NuevaSemilla))
    ).


gato_compu_basico(Lista):- no_llena(Lista), turno_compu_basico(Lista, "O", Lista1, 1), imprimir_tablero(Lista1), (ganador(Lista1); gato_contra_compu_basico(Lista1); empate()). %funcionamiento del juego en modo basico, llama al turno basico de la computadora con una semilla de 1 y realiza las mismas funciones que el gato() mas arriba

gato_contra_compu_basico(Lista):- no_llena(Lista), turno(Lista, "X", Lista1), imprimir_tablero(Lista1), (ganador(Lista1); gato_compu_basico(Lista1); empate()). % funcionamiento del juego en modo basico pero desde el lado del usuario, este es el que empieza y llama al de arriba

gato_compu_avanzado(Lista):- no_llena(Lista), turno_compu_avanzado(Lista, "O", Lista1, 1), imprimir_tablero(Lista1), (ganador(Lista1); gato_contra_compu_avanzado(Lista1); empate()). % funcionamiento del juego en modo avanzado, llama al turno avanzado de la computadora con una semilla de 1 y realiza las mismas funciones que el anterior

gato_contra_compu_avanzado(Lista):- no_llena(Lista), turno(Lista, "X", Lista1), imprimir_tablero(Lista1), (ganador(Lista1); gato_compu_avanzado(Lista1); empate()). % funcionamiento del juego en modo avanzado desde el lado del usuario, este es el que empieza y llama al de arriba



%%% INICIAR EL JUEGO

iniciar_juego_basico():- gato_contra_compu_basico([" "," "," "," "," "," "," "," "," "]). % llama a la regla del modo basico y le da una lista inicial de 9 espacios

iniciar_juego_avanzado():- gato_contra_compu_avanzado([" "," "," "," "," "," "," "," "," "]). % llama a la regla del modo avanzado y le da una lista inicial de 9 espacios

iniciar_juego():- gato([" "," "," "," "," "," "," "," "," "]). % llama a la regla del modo de dos jugadores

%%% MENU PRINCIPAL

jugar():- nl, write("Selecciona modo de juego:"), nl, nl,      % regla principal que inicia todo el juego, mostramos un menu principal con las tres opciones de juego, dependiendo de la entrada del usuario entramos a una u otra
	  write("1. Contra la computadora (modo basico)"), nl,
	  write("2. Contra la computadora (modo avanzado)"), nl,
	  write("3. Modo de dos jugadores"), nl, nl,
	  read(Modo),
	(
	  (Modo is 1) -> 
	  (write("Modo basico contra la computadora"), nl, nl, iniciar_juego_basico())
	  ;
	  (Modo is 2) ->
	  (write("Modo avanzado contra la computadora"), nl, nl, iniciar_juego_avanzado())
	  ;
	  (Modo is 3) ->
	  (write("Modo para dos jugadores"), nl, nl, iniciar_juego())
	  ;
	  (nl, nl, write("Selecciona una opcion valida"), nl, nl, jugar()) % si la entrada no es 1, 2 o 3, se vuelve a pedir
	).
	
