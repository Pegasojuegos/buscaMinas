extends Node2D

var contenido: String = ''
var nBombasCerca: int = 0
var pos: Vector2

signal buscar(pos)
signal cambiarEstado(estado)

func _on_casilla_imagen_me_hicieron_click():
	if contenido == 'x':
		cambiarEstado.emit('x')
	buscar.emit(pos)
