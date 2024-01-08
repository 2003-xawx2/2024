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
	
	if died: 
		state_factory.change_state("die")
		return
	elif character.get_input_movement() != Vector2.ZERO:
		state_factory.change_state("walk")
	elif !character.is_on_floor():
		state_factory.change_state("fall")
	elif Input.is_action_just_pressed("ui_accept"):
		state_factory.change_state("jump")
	elif character.is_attack_input():
		state_factory.change_state("attack")
	else:
		state_factory.change_state("idle")
