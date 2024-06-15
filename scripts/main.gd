extends Node2D

@onready var highscore = $CanvasLayer/Highscore
@onready var play = $CanvasLayer/Play
@onready var quit = $CanvasLayer/Quit

const GAME = preload("res://scenes/game.tscn")

var h_scr = 0

func _ready():
	var scr = "Highscore: " + str(int(h_scr))
	highscore.text = scr

var game

func _on_play_pressed():
	game = GAME.instantiate()
	game.global_position = Vector2(0,0)
	game.main.connect(retrn_main)
	game.high.connect(updt_high)
	game.res.connect(restrt)
	add_child(game)
	play.visible = 0
	quit.visible = 0

func retrn_main():
	remove_child(game)
	get_tree().paused = 0
	play.visible = 1
	quit.visible = 1

func updt_high(score):
	if int(score) > h_scr:
		h_scr = score
	var scr = "Highscore: " + str(int(h_scr))
	highscore.text = scr

func restrt():
	remove_child(game)
	game = GAME.instantiate()
	game = GAME.instantiate()
	game.global_position = Vector2(0,0)
	game.main.connect(retrn_main)
	game.high.connect(updt_high)
	game.res.connect(restrt)
	add_child(game)
	play.visible = 0
	quit.visible = 0


func _on_quit_pressed():
	queue_free()
	get_tree().quit()
