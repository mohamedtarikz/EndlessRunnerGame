extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player
@onready var scrn = get_window().size
@onready var ground = $Ground

var spd = 7.5
var score = 0

func _process(delta):
	player.position.x += spd
	camera.position.x += spd
	
	score += 0.4
	print(int(score))
	
	if camera.position.x - ground.position.x > scrn.x:
		ground.position.x += scrn.x
