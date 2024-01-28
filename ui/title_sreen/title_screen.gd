extends CanvasLayer


const CHECK_1_SUPERMAN = "res://world/check_1_super_man/check_1_superman.tscn"


func _on_start_pressed() -> void:
	Transition.change_scene_to(CHECK_1_SUPERMAN)


func _on_quit_pressed() -> void:
	get_tree().quit()
