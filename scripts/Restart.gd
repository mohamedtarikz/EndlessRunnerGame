extends Label

signal res

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		res.emit()
