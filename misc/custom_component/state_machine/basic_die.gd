extends basic_state
class_name basic_die

@export var hit_collision:CollisionShape2D


func _ready() -> void:
	set_process(false)


func initialize()->void:
	super()
	hit_collision.disabled = true
	set_process(true)
	set_physics_process(true)


func _process(delta: float) -> void:
	if !character.is_on_floor():
		return
	set_physics_process(false)
	animation_player.play("die")
	call_deferred("animation_call_back")
	set_physics_process(false)
	set_process(false)


func animation_call_back()->void:
	await animation_player.animation_finished
	character.process_mode = Node.PROCESS_MODE_DISABLED


func quit()->void:
	character.process_mode = Node.PROCESS_MODE_ALWAYS
	hit_collision.disabled = false
	character.show()
	super()


func _physics_process(delta: float) -> void:
	stand(delta)
