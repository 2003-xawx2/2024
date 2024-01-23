extends basic_state

@onready var attack_timer: Timer = $AttackTimer
@onready var pre_input_jump_timer: Timer = $PreInputJumpTimer
@onready var particles: GPUParticles2D = $"../../Graphic/PlayerSprite/GPUParticles2D"
@onready var hurt_collision: CollisionShape2D = $"../../Graphic/HurtBox/CollisionShape2D"

var if_can_jump:= false


func initialize()->void:
	super()
	animation_player.play("attack")
	attack_timer.start()


func quit()->void:
	super()
	particles.emitting = false
	hurt_collision.disabled = true
	pre_input_jump_timer.stop()
	#attack_timer.stop()


func _physics_process(delta: float) -> void:
	stand(delta)


func _process(delta: float) -> void:
	super(delta)
	if if_can_jump and !pre_input_jump_timer.is_stopped():
		change_state("jump")

	if !attack_timer.is_stopped():
		return

	if character.get_input_movement()==Vector2.ZERO:
		change_state("idle")
	else:
		change_state("walk")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and character.is_on_floor():
		pre_input_jump_timer.start()


#animation_player use
func set_if_can_jump(flag:bool)->void:
	if_can_jump = flag
