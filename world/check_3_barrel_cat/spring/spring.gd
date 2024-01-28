extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_spring_detect_bounce() -> void:
	animation_player.play("bounce")
	$RandomAudioPlayer.play_random()
