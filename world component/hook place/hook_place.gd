extends StaticBody2D
class_name HookPlace

@onready var detect_player: Area2D = $PlayerConnect/DetectPlayer
@onready var player_connect: RigidBody2D = $PlayerConnect
@onready var damped_spring: DampedSpringJoint2D = $DampedSpringJoint2D
@onready var pre_hook_interact_timer: Timer = $PreHookInteractTimer

var is_swing:= false
var player :Node2D = null


func pick_up_player()->bool:
	var bodies := detect_player.get_overlapping_bodies()
	if !bodies.is_empty(): player = bodies.front()
	else: return false
	if player == null: return false
	player = (player as player_character)
	if !player.if_can_swing():
		return false

	is_swing = true
	player.enter_swing_state.call_deferred(player_connect)
	return true


func release_player()->void:
	player.release_swing()
	is_swing = false
	player = null


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("hook swing interact"):
		if !is_swing:
			pre_hook_interact_timer.start()
		else:
			release_player()


func _physics_process(delta: float) -> void:
	if pre_hook_interact_timer.is_stopped():
		return

	if pick_up_player():
		pre_hook_interact_timer.stop()


