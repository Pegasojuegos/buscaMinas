extends Node2D

var contenido: String = ''
var nBombasCerca: int = 0
var pos: Vector2
@export var desmarcada: bool

signal buscar(pos)
signal cambiarEstado(estado,n)
signal explosion()

func _on_casilla_imagen_me_hicieron_click():
	if !desmarcada:
		cambiarEstado.emit(contenido,nBombasCerca)
		desmarcada = true
	match contenido:
		'': buscar.emit(pos)
		'x': explosion.emit()

func desmarcar():
	desmarcada = true
	match contenido:
		'':
			cambiarEstado.emit(contenido,nBombasCerca)
			$esperar.start()
		'n':
			cambiarEstado.emit(contenido,nBombasCerca)


func _on_esperar_timeout():
	buscar.emit(pos)