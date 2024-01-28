extends basic_idle


@onready var detect_board_ray: ShapeCast2D = $"../../Graphic/Ray/DetectBoardRay"
@onready var state_change_timer: Timer = $StateChangeTimer

@export var state_change_time:int = 8


func initialize()->void:
	super()
	state_change_timer.start(randi_range(state_change_time-2,state_change_time+2))


func quit()->void:
	super()
	state_change_timer.stop()


func _physics_process(delta: float) -> void:
	super(delta)


#state change
func _process(delta: float) -> void:
	if character.near_standing_board():
		return
	if detect_board_ray.is_colliding():
		change_state("walk")
	if character.nearby:
		if character.player == null:
			return
		if character.player.dirty:
			change_state("walk")


func _on_state_change_timer_timeout() -> void:
	if character.near_standing_board():
		return
	change_state("walk")
