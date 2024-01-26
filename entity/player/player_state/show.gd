extends basic_state



func initialize()->void:
	super()
	Global.current_camera.check_out_player()
	Global.current_camera.check_out_ready.connect(func():
		animation_player.play("show"),CONNECT_ONE_SHOT)
	animation_player.animation_finished.connect(func(current_animation:String):
		change_state("idle"),CONNECT_ONE_SHOT)


func quit()->void:
	super()


func _physics_process(delta: float) -> void:
	stand(delta)
