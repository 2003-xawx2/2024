extends CharacterBody2D
class_name superman

@onready var animation_player: AnimationPlayer = $Graphic/AnimationPlayer
@onready var state_factory: state_machine = $state_machine
@onready var health_manager: HealthManager = $Component/HealthManager
@onready var hit_box: HitBox = $Component/HitBox
@onready var hit: Node = $state_machine/hit
@onready var recover_invincible: Node2D = $Component/RecoverInvincible
@onready var ridicule: Node2D = $Component/Ridicule
@onready var graphic: Node2D = $Graphic
@onready var head_position_marker: Node2D = $HeadPositionMarker
@onready var head: Sprite2D = $HeadPositionMarker/Head

static var instance:superman

signal attack(flag:bool)

var died:=false
var attacking:=false:
	set(value):
		if attacking == value:
			return
		attacking = value
		attack.emit(value)
	get:
		return attacking
var if_can_dash:=true
var mouse_direction:Vector2


func _ready() -> void:
	instance = self
	Global.player_born_position = global_position
	#state_factory.change_state("show")
	state_factory.change_state("idle")


func _process(delta: float) -> void:
	update_mouse_direction_normalized()
	update_dash()
	flip_on_velocity()


func update_mouse_direction_normalized()->void:
	var mouse_position = head_position_marker.get_local_mouse_position()
	mouse_direction = mouse_position.normalized()
	head.rotation = mouse_direction.angle()


func update_dash()->void:
	if is_on_floor() == true:
		if_can_dash = true


func flip_on_velocity()->void:
	if animation_player.current_animation == "hit" and animation_player.is_playing():
		return
	var velocity_x = velocity.x
	if velocity_x > 1:
		graphic.scale.x = 1
	elif velocity_x < -1:
		graphic.scale.x = -1


func if_in_hit_state()->bool:
	return state_factory.current_state.state_name == "die" or \
		   state_factory.current_state.state_name =="recover" or \
			state_factory.current_state.state_name =="hit"


func recover_from_die():
	recover_invincible.recover()
	health_manager.reset()
	hit.died = false
	died = false


#region handle input

func get_input_movement()->Vector2:
	return Input.get_vector("left","right","down","up")


func is_jump_input()->bool:
	if Input.is_action_pressed("ui_accept"):
		return true
	return false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("super_man_attack"):
		attacking = true
	if event.is_action_released("super_man_attack"):
		attacking = false
	#print(attacking)

	if event.is_action_pressed("super_man_dash"):
		print(!if_in_hit_state())
		if !if_in_hit_state() and if_can_dash:
			if_can_dash = false
			print("enter_dash")
			state_factory.current_state.change_state("dash")

#endregion


#region handle signal

func _on_hit_box_be_hit(direction: Vector2) -> void:
	if died or if_in_hit_state():
		return

	state_factory.current_state.change_state("hit")
	hit.hit_direction = direction


func _on_health_manager_die() -> void:
	hit.died = true
	set_deferred("died",true)
	#print_debug("DEAD!")


func get_face_direction()->Vector2:
	return Vector2(1,0) if graphic.scale.x == 1 else Vector2(-1,0)


func _on_dead() -> void:
	state_factory.current_state.change_state("recover")


func _on_hurt_box_hurt() -> void:
	Global.current_camera.shake(.2,30,10)
	Global.hit_stop(.05,.5)

#endregion

#region interact



#endregion



