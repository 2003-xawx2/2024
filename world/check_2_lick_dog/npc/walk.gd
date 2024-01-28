extends basic_walk


@onready var detect_cliff_ray: RayCast2D = $"../../Graphic/Ray/DetectCliffRay"
@onready var detect_wall_ray: RayCast2D = $"../../Graphic/Ray/DetectWallRay"
@onready var detect_board_ray: ShapeCast2D = $"../../Graphic/Ray/DetectBoardRay"
@onready var state_change_timer: Timer = $StateChangeTimer
@onready var stop_change_move_direction_timer: Timer = $StopChangeMoveDirectionTimer
@onready var run_away_timer = $RunAwayTimer

@export var state_change_time:int = 5
var run_away = 0

var if_can_change_direction:bool = true:
	set(value):
		if_can_change_direction = value
		if value == false:
			stop_change_move_direction_timer.start()
	get:
		return if_can_change_direction


func initialize()->void:
	super()
	state_change_timer.start(randi_range(state_change_time-2,state_change_time+2))
	move_direction = Vector2(1,0) if randi_range(0,1) == 0 else Vector2(-1,0)


func quit()->void:
	super()
	state_change_timer.stop()


func _process(delta: float) -> void:
	if run_away_timer.is_stopped() and run_away:
		character.queue_free()
	if if_can_change_direction:
		if !detect_cliff_ray.is_colliding() or detect_wall_ray.is_colliding():
			move_direction = - move_direction
			if_can_change_direction = false
	if character.nearby:
		if character.player == null:
			return
		if character.player.dirty:
			move_direction = Vector2(character.global_position - character.player.global_position)
			run_away_timer.start()
			run_away = 1
	if detect_board_ray.is_colliding():
		if character.near_standing_board():
			change_state("idle")
		move_direction = - detect_board_ray.get_collision_normal(0)


func _on_state_change_timer_timeout() -> void:
	change_state("idle")


func _on_stop_change_move_direction_timer_timeout() -> void:
	if_can_change_direction = true
