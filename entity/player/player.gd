extends CharacterBody2D
class_name player_character

@onready var animation_player: AnimationPlayer = $Graphic/AnimationPlayer
@onready var state_factory: state_machine = $state_machine
@onready var hit_box: HitBox = $Component/HitBox
@onready var swing: Node = $state_machine/swing
@onready var hit: Node = $state_machine/hit
@onready var health_manager: HealthManager = $Component/HealthManager
@onready var graphic: Node2D = $Graphic
@onready var recover_invincible: Node2D = $Component/RecoverInvincible
@onready var ridicule: Node2D = $Component/Ridicule

static var instance:player_character
var died:=false


func _ready() -> void:
	instance = self
	Global.player_born_position = global_position
	state_factory.change_state("show")


func _process(delta: float) -> void:
	flip_on_velocity()


func flip_on_velocity()->void:
	if animation_player.current_animation == "hit" and animation_player.is_playing():
		return
	var velocity_x = velocity.x
	if velocity_x > 1:
		graphic.scale.x = 1
	elif velocity_x < -1:
		graphic.scale.x = -1


func recover_from_die():
	recover_invincible.recover()
	health_manager.reset()
	hit.died = false
	died = false


#region handle input

func get_input_movement()->Vector2:
	return Input.get_vector("left","right","down","up")


func is_attack_input()->bool:
	if Input.is_action_pressed("attack"):
		return true
	return false


func is_jump_input()->bool:
	if Input.is_action_pressed("ui_accept"):
		return true
	return false

#endregion

#region handle signal

func _on_hit_box_be_hit(direction: Vector2) -> void:
	if died or state_factory.current_state.state_name == "die" || "recover" || "hit":
		return

	state_factory.current_state.change_state("hit")
	hit.hit_direction = direction


func _on_health_manager_die() -> void:
	hit.died = true
	set_deferred("died",true)
	print_debug("DEAD!")


func get_face_direction()->Vector2:
	return Vector2(1,0) if graphic.scale.x == 1 else Vector2(-1,0)


func _on_dead() -> void:
	state_factory.current_state.change_state("recover")


func _on_hurt_box_hurt() -> void:
	Global.current_camera.shake(.2,30,10)
	Global.hit_stop(.05,.5)

#endregion

#region interact

func if_can_swing()->bool:
	if state_factory.current_state.state_name == "jump" || "fall":
		return true
	return false


func release_swing()->void:
	swing.release_swing()


func enter_swing_state(connect_place:RigidBody2D)->void:
	swing.player_connect = connect_place
	state_factory.current_state.change_state("swing")


#endregion



