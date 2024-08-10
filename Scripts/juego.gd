extends Node2D

var casillas:Array 
var casilla_scene: PackedScene = preload("res://escenas/casilla.tscn")
@export var tamaño:int = 10
@export var nBombas = 10
@export var separacionCasillas: int = 20


func _ready():
	casillas = Array()
	for i:int in range(tamaño):
		casillas.append(Array())
		for j:int in range(tamaño): #i * tamaño + j
			var casilla = casilla_scene.instantiate()
			$contenedorCasillas.add_child(casilla)
			casilla.position = Vector2(i*separacionCasillas,j*separacionCasillas)
			casilla.pos = Vector2(i,j)
			casilla.connect("buscar", Callable(self, "_on_casilla_buscar"))
			casillas[i].append(casilla)
	
	for n:int in range(nBombas):
		var hayBomba = true
		var x:int
		var y:int
		while hayBomba:
			x = (randf_range(0,tamaño-1))
			y = (randf_range(0,tamaño-1))
			if casillas[x][y].contenido != 'x':
				hayBomba = false
		
		casillas[x][y].contenido = 'x'
		if x < tamaño-1: casillas[x+1][y].nBombasCerca += 1
		if y < tamaño-1: casillas[x][y+1].nBombasCerca += 1
		if x < tamaño-1 && y < tamaño-1: casillas[x+1][y+1].nBombasCerca += 1
		if x > 0 && y > 0: casillas[x-1][y-1].nBombasCerca += 1
		if x < tamaño-1 && y > 0: casillas[x+1][y-1].nBombasCerca += 1
		if x > 0 && y < tamaño-1: casillas[x-1][y+1].nBombasCerca += 1
		if y > 0: casillas[x][y-1].nBombasCerca += 1 
		if x > 0: casillas[x-1][y].nBombasCerca += 1


func _on_casilla_buscar(pos: Vector2):
	print(casillas[pos.x][pos.y].nBombasCerca)
