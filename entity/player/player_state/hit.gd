extends basic_hit


func _ready() -> void:
	super()


func initialize()->void:
	super()
	Global.hit_stop(.15,.3)
	Global.current_camera.shake(.1,200,10)


func quit()->void:
	super()


func _process(delta: float) -> void:
	super(delta)

	#state change
	if animation_player.is_playing():
		return

	print_debug(died)
	if died:
		change_state("die")
	elif character.get_input_movement() != Vector2.ZERO:
		change_state("walk")
	elif !character.is_on_floor():
		change_state("fall")
	elif Input.is_action_just_pressed("ui_accept"):
		change_state("jump")
	elif character.is_attack_input():
		change_state("attack")
	else:
		change_state("idle")
