extends Area2D
class_name CheckPoint

@onready var flag: Sprite2D = $Flag
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var _ridicule: ridicule = $Ridicule

@export var random_talk:Array[String]

var if_checked = false


func _ready() -> void:
	unchceked()


func unchceked()->void:
	animation_player.play_backwards("pass")


func checked()->void:
	if_checked = true
	animation_player.play("pass")
	_ridicule.talk(random_talk.pick_random(),1)
	Global.current_check_point = self



func _on_body_entered(body: Node2D) -> void:
	if if_checked:return

	checked()
