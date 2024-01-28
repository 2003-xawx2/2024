extends air_state

@export_category("jump")
@export var jump_frames:int = 3
@export var jump_acceleration_y:float=300
@export var jump_velocity_y:float=-300

@export var random_talk:Array[String]

var temp_jump_frames:int


func initialize()->void:
	super()
	$RandomAudioPlayer.play_random()
	temp_jump_frames = jump_frames
	animation_player.play("jump")
	character.ridicule.talk(random_talk.pick_random(),.4)


func quit()->void:
	super()


func _physics_process(delta: float) -> void:
	if temp_jump_frames > 0:
		temp_jump_frames -= 1
		jump(delta)
		return

	var input_vector = character.get_input_movement()

	if character.is_jump_input() and state_time < .5:
		air_move(delta,default_gravity / 1.3)
	else:
		air_move(delta,default_gravity * 1.3)


func _process(delta: float) -> void:
	super(delta)
	#state change
	if character.velocity.y>=-1 and state_time>.05:
		change_state("fall")


func jump(delta)->void:
	var velocity :Vector2 = character.velocity

	velocity.x = lerp(velocity.x,character.get_input_movement().x*max_speed,1-exp(-delta*acceleration))
	velocity.y = lerp(velocity.y,jump_velocity_y,1-exp(-delta*jump_acceleration_y))

	character.velocity = velocity
	character.move_and_slide()
