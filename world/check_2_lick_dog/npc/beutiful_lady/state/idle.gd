extends basic_idle


@onready var detect_player_ray: ShapeCast2D = $"../../Graphic/Ray/DetectPlayerRay"
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
	if detect_player_ray.is_colliding():
		change_state("attack")


func _on_state_change_timer_timeout() -> void:
	change_state("walk")
