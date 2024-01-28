extends basic_walk

@onready var detect_wall_ray: RayCast2D = $"../../Graphic/DetectWallRay"
@onready var detect_board_ray = $"../../DetectBoardRay"


func _ready():
	super()


func initialize()->void:
	super()
	(character as CharacterBody2D).ridicule.talk("润！",.1)


func quit()->void:
	super()


func _physics_process(delta: float) -> void:
	move_direction = character.get_input_movement()
	if character.npc.global_position.x<character.global_position.x:
		move_direction.x -= ( - character.npc.global_position.x + character.global_position.x)

	move(delta,move_direction)


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

