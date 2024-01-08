extends basic_idle


func initialize()->void:
	super()


func quit()->void:
	super()


func _process(delta: float) -> void:
	super(delta)
	#state change
	if character.get_input_movement() != Vector2.ZERO:
		state_factory.change_state("walk")
	elif !character.is_on_floor():
		state_factory.change_state("fall")
	elif Input.is_action_just_pressed("ui_accept"):
		state_factory.change_state("jump")
	elif character.is_attack_input():
		state_factory.change_state("attack")
