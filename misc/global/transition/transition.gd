extends CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect


func _ready() -> void:
	color_rect.hide()


func change_scene_to(path:String)->void:
	color_rect.show()
	animation_player.play("ease_in")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(path)
	animation_player.play("ease_out")
	await animation_player.animation_finished
	color_rect.hide()
