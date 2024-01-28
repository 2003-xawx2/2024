extends air_state

@onready var pre_input_jump_timer: Timer = $PreInputJumpTimer
@onready var pre_input_attack_timer: Timer = $PreInputAttackTimer
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var fall_detecte_enemy_ray: RayCast2D = $"../../Graphic/FallDetecteEnemyRay"


var is_landing:bool = false
var is_character_on_floor:=false


func _ready() -> void:
	super()
	await owner.ready


func initialize()->void:
	super()
	is_landing = false
	is_character_on_floor = false
	animation_player.play("fall")
	animation_player.animation_finished.connect(func(animation:String):
		if animation != "fall" or !is_work:
			return
		if character.get_input_movement()==Vector2.ZERO:
			change_state("idle")
		else:
			change_state("walk")
			,CONNECT_ONE_SHOT)
	if state_factory.previos_state.state_name == "walk":
		coyote_timer.start()


func quit()->void:
	super()
	pre_input_jump_timer.stop()
	pre_input_attack_timer.stop()
	coyote_timer.stop()


func _physics_process(delta: float) -> void:
	air_move(delta,default_gravity)


func _process(delta: float) -> void:
	super(delta)
	is_character_on_floor = character.is_on_floor()

	if !pre_input_jump_timer.is_stopped():
		if is_character_on_floor:
			change_state("jump")
		elif !coyote_timer.is_stopped():
			change_state("jump")
	elif fall_detecte_enemy_ray.is_colliding():
		change_state("jump")



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		pre_input_jump_timer.start()
