extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player
@onready var scrn = get_window().size
@onready var ground = $Ground
@onready var scoreLabel = $CanvasLayer/score
@onready var start = $CanvasLayer/start
@onready var start_col = $CanvasLayer/start_col
@onready var lost = $CanvasLayer/Lost
@onready var restart = $CanvasLayer/Restart
@onready var button = $CanvasLayer/Button
@onready var game = $"."

const CACTUS_1 = preload("res://scenes/cactus_1.tscn")
const CACTUS_2 = preload("res://scenes/cactus_2.tscn")
const CACTUS_3 = preload("res://scenes/cactus_3.tscn")
const CACTUS_4 = preload("res://scenes/cactus_4.tscn")
const CACTUS_H = preload("res://scenes/cactus_h.tscn")
var obs_lst = [CACTUS_1,CACTUS_2,CACTUS_3,CACTUS_4,CACTUS_H]

var spd = 7.5
var score = 0
var game_begin = 0
var pos
var obs
var las_obs = 112.0
var idx

func _physics_process(delta):
	if game_begin:
		spd = 7.5 + score / 40
		if spd > 27:
			spd = 27
		
		player.position.x += spd
		camera.position.x += spd
		
		score += 0.4
		scoreLabel.text = "Score: " + str(int(score))
		
		if camera.position.x - ground.position.x > scrn.x:
			ground.position.x += scrn.x
		
		if (camera.global_position.x + scrn.x - las_obs) > (500 + spd * 2):
			pos = randi() % 150 + 30
			if score <= 175:
				idx = randi() % 2
			elif score <= 450:
				idx = randi() % 3
			elif score <= 900:
				idx = randi() % 4
			else:
				idx = randi() % 5
			obs = obs_lst[idx].instantiate()
			obs.global_position = Vector2(player.global_position.x + scrn.x + pos, 560)
			las_obs = obs.global_position.x
			if idx == 1:
				las_obs += 23
			elif idx == 2:
				las_obs += 172
			elif idx == 3:
				las_obs += 386
			elif idx == 4:
				las_obs += 678
			obs.ht.connect(is_col)
			add_child(obs)
	else:
		player.get_node("Sprite").play("idle")
		if Input.is_action_just_pressed("start"):
			game_begin = 1
			start.visible = 0
			start_col.visible = 0
			lost.visible = 0
			restart.visible = 0

func is_col(body):
	if body.name == "Player":
		game_over()

signal high

func game_over():
	high.emit(score)
	game_begin = 0
	start_col.visible = 1
	lost.visible = 1
	get_tree().paused = 1
	restart.visible = 1
	button.visible = 1
	restart.res.connect(strt)
	button.pressed.connect(kil)

signal res

func strt():
	get_tree().paused = false
	res.emit()

signal main

func kil():
	print("kill")
	main.emit()
