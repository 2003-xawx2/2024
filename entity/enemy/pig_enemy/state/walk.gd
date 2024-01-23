extends basic_walk


@onready var detect_cliff_ray: RayCast2D = $"../../Graphic/Ray/DetectCliffRay"
@onready var detect_wall_ray: RayCast2D = $"../../Graphic/Ray/DetectWallRay"
@onready var detect_player_ray: ShapeCast2D = $"../../Graphic/Ray/DetectPlayerRay"
@onready var state_change_timer: Timer = $StateChangeTimer
@onready var stop_change_move_direction_timer: Timer = $StopChangeMoveDirectionTimer

@export var state_change_time:int = 5

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
	if if_can_change_direction:
		if !detect_cliff_ray.is_colliding() or detect_wall_ray.is_colliding():
			move_direction = - move_direction
			if_can_change_direction = false

	#stage change
	if detect_player_ray.is_colliding():
		change_state("attack")


func _on_state_change_timer_timeout() -> void:
	change_state("idle")


func _on_stop_change_move_direction_timer_timeout() -> void:
	if_can_change_direction = true
