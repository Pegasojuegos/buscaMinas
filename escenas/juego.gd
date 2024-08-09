extends Node2D

var casillas:Array 
var tamaño:int = 10
var casilla_scene: PackedScene = preload("res://escenas/casilla.tscn")
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

func _on_casilla_buscar(pos: Vector2):
	print(casillas[pos.x][pos.y])
