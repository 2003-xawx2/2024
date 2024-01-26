extends Node2D
class_name ridicule

var tween:Tween

@export var tween_time: = .5
@export var auto_hide_time: = 1
@export_range(0,1) var talk_chance := .3

@onready var label: Label = $Label
@onready var auto_hide_timer: Timer = $AutoHideTimer


func _ready() -> void:
	label.modulate.a = 0


func talk(text:String,chance:float = talk_chance):
	if randf_range(0,1) > chance:
		return

	show_label()
	label.text = text


func show_label()->void:
	if tween and tween.is_running():
		tween.kill()

	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(label,"modulate:a",1,tween_time)
	auto_hide_timer.start(auto_hide_time)


func hide_label()->void:
	if tween and tween.is_running():
		tween.kill()

	tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(label,"modulate:a",0,tween_time)


func _on_auto_hide_timer_timeout() -> void:
	hide_label()
