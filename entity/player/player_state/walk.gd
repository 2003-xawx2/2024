extends basic_walk

@onready var detect_wall_ray: RayCast2D = $"../../Graphic/DetectWallRay"


func initialize()->void:
	super()


func quit()->void:
	super()


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
	elif character.is_attack_input():
		change_state("attack")
	elif move_direction == Vector2.ZERO or\
	 detect_wall_ray.is_colliding() and (character.get_face_direction()*move_direction).x>0:
		change_state("idle")
