extends StaticBody2D

signal ht



func _on_cactus_obs_body_entered(body):
	ht.emit(body)


func _on_cactus_obs_2_body_entered(body):
	ht.emit(body)


func _on_cactus_obs_3_body_entered(body):
	ht.emit(body)


func _on_cactus_obs_4_body_entered(body):
	ht.emit(body)


func _on_cactus_obs_5_body_entered(body):
	ht.emit(body)


func _on_timer_timeout():
	queue_free()
