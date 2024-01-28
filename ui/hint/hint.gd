extends CanvasLayer

@onready var timer: Timer = $Timer

@export var sprite:Sprite2D
@export var area:Area2D


var tween:Tween


func _ready() -> void:
	area.body_entered.connect(func(body):
		show_hint())


func show_hint()->void:
	change_modulate(1)
	timer.start()


func change_modulate(target:=1):
	if tween and tween.is_running():
		tween.kill()

	tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(sprite,"modulata:a",1,target)


func _on_timer_timeout() -> void:
	change_modulate(0)
