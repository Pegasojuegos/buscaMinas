extends Node2D

var contenido: String 
var pos: Vector2

signal buscar(pos)



func _on_casilla_imagen_me_hicieron_click():
	print(pos)
	buscar.emit(pos)
