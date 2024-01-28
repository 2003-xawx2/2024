extends basic_idle

@onready var detect_wall_ray: RayCast2D = $"../../Graphic/DetectWallRay"


func initialize()->void:
	super()


func quit()->void:
	super()


func _process(delta: float) -> void:
	super(delta)
	#state change
	var move_direction = character.get_input_movement()
	if  move_direction!= Vector2.ZERO and !(detect_wall_ray.is_colliding() and (character.get_face_direction()*move_direction).x>0):
		change_state("walk")
	elif !character.is_on_floor():
		change_state("fall")
	elif Input.is_action_just_pressed("ui_accept"):
		change_state("jump")
