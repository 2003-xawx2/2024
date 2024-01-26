extends basic_state
class_name basic_die

signal die_animation_finished

@export var hit_collision:CollisionShape2D


func _ready() -> void:
	super()
	set_process(false)


func initialize()->void:
	super()
	print_debug("initialize DEAD!")
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
	die_animation_finished.emit()
	#character.process_mode = Node.PROCESS_MODE_DISABLED


func quit()->void:
	#character.process_mode = Node.PROCESS_MODE_INHERIT
	hit_collision.disabled = false
	character.show()
	super()


func _physics_process(delta: float) -> void:
	stand(delta)
