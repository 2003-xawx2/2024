extends AudioStreamPlayer2D


@export var finish_again_time:= 15


func _on_finished() -> void:
	await get_tree().create_timer(finish_again_time).timeout
	play()
