extends basic_state

@export var force_mulitiper:float = 5
@export var enhance_y_vel:= 40

var right:=true
var left:=false
var player_connect:RigidBody2D
var record_velocity:Vector2
var last_apply_delta:=0
var first_apply_delta:=0


func initialize():
	super()
	(character as player_character).ridicule.talk("就是玩",.6)
	first_apply_delta = 1


func quit():
	super()


func _physics_process(delta: float) -> void:
	if first_apply_delta == 1:
		first_apply_delta = 0
		var force = Vector2(character.velocity.x,character.velocity.y / 2)
		player_connect.apply_impulse(force)
		character.velocity = Vector2.ZERO
		character.move_and_slide()
		return

	if last_apply_delta == 1:
		last_apply_delta = 0
		var enhanced_velocity = Vector2(record_velocity.x * 1.2,record_velocity.y - enhance_y_vel)
		character.velocity = enhanced_velocity
		character.move_and_slide()
		change_state("fall")
		return

	var player_force :Vector2 = Vector2.ZERO
	if left:
		player_force += Vector2.LEFT
	if right:
		player_force += Vector2.RIGHT
	player_force *= force_mulitiper
	player_connect.apply_force(player_force)

	var new_position = player_connect.global_position
	#player_connect.apply_force(default_gravity*Vector2.DOWN)
	record_velocity = (new_position - character.global_position)/delta
	character.global_position = new_position
	character.velocity = Vector2.ZERO
	character.move_and_slide()


func release_swing()->void:
	last_apply_delta = 1


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		left = true
	elif event.is_action_released("left"):
		left = false
	if event.is_action_pressed("right"):
		right = true
	elif event.is_action_released("right"):
		right = false




