extends Node2D

var casillas:Array 
var casilla_scene: PackedScene = preload("res://escenas/casilla.tscn")
@export var tamaño:int = 10
@export var nBombas = 10
@export var separacionCasillas: int = 20

#Temporizador
var minutos: int
var segundos: int
@export var totalMinutos: int = 2
@export var totalSegundos: int = 30


func _ready():
	casillas = Array()
	#Creamos un array y en cada casilla i metemos un array (Creación de matriz)
	for i:int in range(tamaño): 
		casillas.append(Array())
		for j:int in range(tamaño): 
			#Por cada casilla j de la matriz creamos una instancia de cailla
			var casilla = casilla_scene.instantiate()
			#Lo añadimos al arbol de Juego
			$contenedorCasillas.add_child(casilla)
			#Lo colocamos en la posición de pantalla deseada.
			casilla.position = Vector2(i*separacionCasillas,j*separacionCasillas)
			#Guardamos en el propio objeto su ubicación (i,j) que tendrá dentro de la matriz
			casilla.pos = Vector2(i,j)
			#Conectamos la señal buscar de casilla con un receptor aquí en juego
			casilla.connect("buscar", Callable(self, "_on_casilla_buscar"))
			casilla.connect("explosion", Callable(self, "_on_casilla_explosion"))
			#Guadamos la casilla creada en la matriz
			casillas[i].append(casilla)
	
	#Creación de n bombas
	for n:int in range(nBombas):
		var hayBomba = true
		var x:int
		var y:int
		#Imitación de doWhile, para que genere un número y lo vuelva a generar hasta que en esa posición no haya una bomba
		while hayBomba: 
			x = (randf_range(0,tamaño-1))
			y = (randf_range(0,tamaño-1))
			if casillas[x][y].contenido != 'x':
				hayBomba = false
		
		#Añade una bomba a la posición 
		casillas[x][y].contenido = 'x'
		# Para cada casilla de alrededor que este dentro del mapa y no tenga bomba
		# suma uno a sus bombas cercanas y cambio su contenido
		if x < tamaño-1 && casillas[x+1][y].contenido!= 'x': 
			casillas[x+1][y].nBombasCerca += 1
			casillas[x+1][y].contenido = 'n'
		if y < tamaño-1 && casillas[x][y+1].contenido!= 'x':
			casillas[x][y+1].nBombasCerca += 1
			casillas[x][y+1].contenido = 'n'
		if x < tamaño-1 && y < tamaño-1 && casillas[x+1][y+1].contenido!= 'x': 
			casillas[x+1][y+1].nBombasCerca += 1
			casillas[x+1][y+1].contenido = 'n'
		if x > 0 && y > 0 && casillas[x-1][y-1].contenido!= 'x': 
			casillas[x-1][y-1].nBombasCerca += 1
			casillas[x-1][y-1].contenido = 'n'
		if x < tamaño-1 && y > 0 && casillas[x+1][y-1].contenido!= 'x': 
			casillas[x+1][y-1].nBombasCerca += 1
			casillas[x+1][y-1].contenido = 'n'
		if x > 0 && y < tamaño-1 && casillas[x-1][y+1].contenido!= 'x': 
			casillas[x-1][y+1].nBombasCerca += 1
			casillas[x-1][y+1].contenido = 'n'
		if y > 0 && casillas[x][y-1].contenido!= 'x': 
			casillas[x][y-1].nBombasCerca += 1 
			casillas[x][y-1].contenido = 'n'
		if x > 0 && casillas[x-1][y].contenido!= 'x': 
			casillas[x-1][y].nBombasCerca += 1
			casillas[x-1][y].contenido = 'n'
			
	reiniciarTemporizador()


func _on_casilla_buscar(pos: Vector2):
	var x = pos.x
	var y = pos.y
	if x < tamaño-1 && casillas[x+1][y].contenido != 'x' && !casillas[x+1][y].desmarcada: 
		casillas[x+1][y].desmarcar()
	if y < tamaño-1 && casillas[x][y+1].contenido != 'x' && !casillas[x][y+1].desmarcada:
		casillas[x][y+1].desmarcar()
	if x < tamaño-1 && y < tamaño-1 && casillas[x+1][y+1].contenido != 'x' && !casillas[x+1][y+1].desmarcada: 
		casillas[x+1][y+1].desmarcar()
	if x > 0 && y > 0 && casillas[x-1][y-1].contenido != 'x' && !casillas[x-1][y-1].desmarcada: 
		casillas[x-1][y-1].desmarcar()
	if x < tamaño-1 && y > 0 && casillas[x+1][y-1].contenido != 'x' && !casillas[x+1][y-1].desmarcada: 
		casillas[x+1][y-1].desmarcar()
	if x > 0 && y < tamaño-1 && casillas[x-1][y+1].contenido != 'x' && !casillas[x-1][y+1].desmarcada: 
		casillas[x-1][y+1].desmarcar()
	if y > 0 && casillas[x][y-1].contenido != 'x' && !casillas[x][y-1].desmarcada: 
		casillas[x][y-1].desmarcar()
	if x > 0 && casillas[x-1][y].contenido != 'x' && !casillas[x-1][y].desmarcada: 
		casillas[x-1][y].desmarcar()


func _on_casilla_explosion():
	finJuego('boom')

func finJuego(motivo: String):
	print(motivo)
	$temporizador.stop()


func _on_timer_timeout():
	if segundos == 0 && minutos == 0: finJuego("Tiempo")
	else:
		if segundos == 0:
			if minutos > 0: 
				minutos -= 1
				segundos = 59
		else: segundos -= 1
		$Label.text = str(minutos)+":"+str(segundos)


func reiniciarTemporizador():
	minutos = totalMinutos
	segundos = totalSegundos
	$Label.text = str(minutos)+":"+str(segundos)
	$temporizador.start()
