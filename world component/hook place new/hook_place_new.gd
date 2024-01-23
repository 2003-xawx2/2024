extends StaticBody2D
class_name HookPlaceNew

@onready var detect_player: Area2D = $PlayerConnect/DetectPlayer
@onready var player_connect: RigidBody2D = $PlayerConnect
@onready var pre_hook_interact_timer: Timer = $PreHookInteractTimer
@onready var rope_piece: RigidBody2D = $PinJoint2D/RopePiece

@export var rope_piece_length:float = 20
@export var rope_piece_nums:int = 5

const ROPE_PIECE = preload("res://world component/hook place new/RopePiece/rope_piece.tscn")

var is_swing:= false
var player :Node2D = null


func _ready() -> void:
	rope_piece.initialize(rope_piece_nums,rope_piece_length,player_connect)


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


func _input(event: InputEvent) -> void:
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
