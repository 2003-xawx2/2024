extends Area2D


@export_file() var next_scene:String


func _on_body_entered(body: Node2D) -> void:
	var random = randi_range(1,3)
	if random == 1:
		BigWorldMode.show_word_three("你","又吃","云南蘑菇",1)
	if random == 2:
		BigWorldMode.show_word_two("入","梦！",1)
	if random == 3:
		BigWorldMode.show_word_one("别做梦了",1)

	await get_tree().create_timer(2).timeout
	Transition.change_scene_to(next_scene)
