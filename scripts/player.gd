extends CharacterBody2D

@onready var sprite = $Sprite
@onready var stndv = $stnd_v
@onready var stndh = $stnd_h
@onready var lowv = $low_v
@onready var lowh = $low_h

const JMP = -1600
const GRV = 4200

var game_begin = 0

func _physics_process(delta):
	if game_begin:
		if is_on_floor():
			stndh.disabled = 0
			stndv.disabled = 0
			lowh.disabled = 1
			lowv.disabled = 1
			if Input.is_action_just_pressed("jump"):
				velocity.y = JMP
				sprite.play("jump")
			elif Input.is_action_pressed("roll"):
				sprite.play("low")
				stndh.disabled = 1
				stndv.disabled = 1
				lowh.disabled = 0
				lowv.disabled = 0
			else:
				sprite.play("run")
		else:
			velocity.y += GRV * delta
			
		move_and_slide()
	else:
		sprite.play("idle")
		if Input.is_action_just_pressed("ui_accept"):
			game_begin = 1
			velocity.y = JMP
			sprite.play("jump")
