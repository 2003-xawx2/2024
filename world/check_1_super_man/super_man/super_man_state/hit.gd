extends basic_hit

@export var random_talk:Array[String]


func _ready() -> void:
	super()


func initialize()->void:
	super()
	character.ridicule.talk(random_talk.pick_random(),1)
	$RandomAudioPlayer.play_random()
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
		change_state("die")
	elif character.get_input_movement() != Vector2.ZERO:
		change_state("walk")
	elif !character.is_on_floor():
		change_state("fall")
	elif Input.is_action_just_pressed("ui_accept"):
		change_state("jump")
	else:
		change_state("idle")
