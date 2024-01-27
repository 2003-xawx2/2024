extends Area2D

enum State{
	NoCollisionWithVisiual,
	NoVisiualWithCollison,
}

@onready var change_timer: Timer = $ChangeTimer

@export var change_time:float = 4
@export var collision:CollisionShape2D
@export var manage_object:Node2D
@export var object_state:State


var tween:Tween


func _ready() -> void:
	if object_state == State.NoCollisionWithVisiual:
		change_modulate(1)
		collision.disabled = true
	elif object_state == State.NoVisiualWithCollison:
		change_modulate(0)
		collision.disabled = false


func interact()->void:
	change_timer.start(change_time)
	if object_state == State.NoCollisionWithVisiual:
		change_modulate(0.1)
	elif object_state == State.NoVisiualWithCollison:
		change_modulate(0.9)


func change_modulate(target:float,duration:int = 1):
	if tween and tween.is_running():
		tween.kill()

	tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(manage_object,"modulate:a",target,duration)


func _on_change_timer_timeout() -> void:
	if object_state == State.NoCollisionWithVisiual:
		change_modulate(1)
	elif object_state == State.NoVisiualWithCollison:
		change_modulate(0)


func _on_body_entered(body: Node2D) -> void:
	interact()


func _on_area_entered(area: Area2D) -> void:
	interact()
