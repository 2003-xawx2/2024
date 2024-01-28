extends basic_walk

@onready var detect_wall_ray: RayCast2D = $"../../Graphic/DetectWallRay"
@onready var timer: Timer = $RandomAudioPlayer/Timer
@export var random_talk:Array[String]

func initialize()->void:
	super()
	character.ridicule.talk(random_talk.pick_random(),.2)
	$RandomAudioPlayer.play_random()
	character.ridicule.talk("润！",.1)
	timer.start()


func quit()->void:
	super()
	timer.stop()


func _physics_process(delta: float) -> void:
	super(delta)


func _process(delta: float) -> void:
	super(delta)
	move_direction = character.get_input_movement()

	#state change
	if !character.is_on_floor():
		change_state("fall")
	elif Input.is_action_just_pressed("ui_accept"):
		change_state("jump")
	elif move_direction == Vector2.ZERO or\
	 detect_wall_ray.is_colliding() and (character.get_face_direction()*move_direction).x>0:
		change_state("idle")


func _on_timer_timeout() -> void:
	$RandomAudioPlayer.play_random()
