extends basic_walk

@onready var detect_cliff_ray: RayCast2D = $"../../Graphic/Ray/DetectCliffRay"
@onready var detect_wall_ray: RayCast2D = $"../../Graphic/Ray/DetectWallRay"
@onready var detect_player_ray: ShapeCast2D = $"../../Graphic/Ray/DetectPlayerRay"
@onready var state_change_timer: Timer = $StateChangeTimer
@onready var stop_change_move_direction_timer: Timer = $StopChangeMoveDirectionTimer

@export var state_change_time:int = 4

var if_can_change_direction:bool = true:
	set(value):
		if_can_change_direction = value
		if value == false:
			stop_change_move_direction_timer.start()
	get:
		return if_can_change_direction


func initialize()->void:
	super()
	state_change_timer.start(state_change_time)
	move_direction = Vector2(1,0) if randi_range(0,1) == 0 else Vector2(-1,0)


func quit()->void:
	super()
	state_change_timer.stop()


func _process(delta: float) -> void:
	if if_can_change_direction:
		if !detect_cliff_ray.is_colliding() or detect_wall_ray.is_colliding():
			#print("change")
			move_direction = - move_direction
			if_can_change_direction = false
	
	if detect_player_ray.is_colliding():
		state_change_timer.start(state_change_time)
		move_direction = character.get_attack_vector()


#stage change
func _on_state_change_timer_timeout() -> void:
	state_factory.change_state("walk")


func _on_stop_change_move_direction_timer_timeout() -> void:
	if_can_change_direction = true
