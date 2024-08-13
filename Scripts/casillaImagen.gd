extends Sprite2D



signal meHicieronClick()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and get_rect().has_point(to_local(event.position)):
		meHicieronClick.emit()


func _on_casilla_cambiar_estado(estado,n):
	match estado:
		'x': $".".texture=ResourceLoader.load("res://assets/bomba.png")
		'n': 
			var texture_path = "res://assets/" + str(n) + ".png"
			$".".texture = ResourceLoader.load(texture_path)
		'': $".".texture=ResourceLoader.load("res://assets/desmarcada.png")
