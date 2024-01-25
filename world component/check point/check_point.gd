extends Area2D
class_name CheckPoint

@onready var flag: Sprite2D = $Flag
@onready var color_rect: ColorRect = $Flag/ColorRect

var if_checked = false


func _ready() -> void:
	unchceked()


func unchceked()->void:
	color_rect.color = Color.WHITE


func checked()->void:
	if_checked = true
	color_rect.color = Color.DARK_GREEN
	Global.current_check_point = self


func _on_body_entered(body: Node2D) -> void:
	if if_checked:return

	checked()
