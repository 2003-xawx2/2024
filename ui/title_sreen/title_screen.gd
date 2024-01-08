extends CanvasLayer


const MAIN_WORLD = "res://world/main_world.tscn"


func _on_start_pressed() -> void:
	Transition.change_scene_to(MAIN_WORLD)


func _on_quit_pressed() -> void:
	get_tree().quit()
