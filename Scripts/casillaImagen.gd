extends Sprite2D

var bandera = false

signal meHicieronClick()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and get_rect().has_point(to_local(event.position)):
		if bandera:
			bandera = false
			$".".texture=ResourceLoader.load("res://assets/marcada.png")
		else:
			meHicieronClick.emit()
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT and get_rect().has_point(to_local(event.position)):
		if bandera:
			bandera = false
			$".".texture=ResourceLoader.load("res://assets/marcada.png")
		else:
			bandera = true
			$".".texture=ResourceLoader.load("res://assets/Sprites/flag.png")


func _on_casilla_cambiar_estado(estado,n):
	match estado:
		'x': $".".texture=ResourceLoader.load("res://assets/bomba.png")
		'n': 
			var texture_path = "res://assets/Sprites/" + str(n) + ".png"
			$".".texture = ResourceLoader.load(texture_path)
		'': $".".texture=ResourceLoader.load("res://assets/Sprites/desmarcada.png")
