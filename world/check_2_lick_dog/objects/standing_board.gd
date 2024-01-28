extends Node2D


@onready var detect_area = $"DetectArea"
@onready var wait = $"WaitForInteract"

@export var pickup_y: float
var player = null
var is_carry = 0


func enter()->bool:
	var bodies := detect_area.get_overlapping_bodies() as Array
	if !bodies.is_empty():
		player = bodies.front()
	else:
		return false
	if player == null:
		return false
	player.carry_standing_board.call_deferred(self)
	is_carry = 1
	return true


func release_board():
	global_position.y += pickup_y
	is_carry = 0
	player = null


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("world2_interact"):
		if !is_carry:
			wait.start()
		else:
			release_board()


func _physics_process(delta):
	if is_carry:
		global_position.x = player.global_position.x
		global_position.y = player.global_position.y - pickup_y
	if wait.is_stopped():
		return
	if enter():
		wait.stop()




#pig
