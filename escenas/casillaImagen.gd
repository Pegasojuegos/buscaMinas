extends Sprite2D

@export var desmarcada: bool

signal meHicieronClick()

func _input(event):
	if !desmarcada and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and get_rect().has_point(to_local(event.position)):
		desmarcada = true
		$".".texture=ResourceLoader.load("res://assets/desmarcada.png");
		meHicieronClick.emit()

