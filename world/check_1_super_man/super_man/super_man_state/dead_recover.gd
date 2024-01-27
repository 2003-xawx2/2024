extends basic_state


var tween:Tween


func initialize()->void:
	super()
	character.died = false
	character.process_mode = Node.PROCESS_MODE_INHERIT

	change_modulate(0)
	await tween.finished

	character.global_position = Global.get_player_recover_position()
	change_modulate(1,.3)
	change_state.call_deferred("fall")


func quit()->void:
	super()
	character.recover_from_die()


func change_modulate(target:float,duration:float = 1)->void:
	if tween and tween.is_running():
		tween.kill()

	tween = character.create_tween()
	tween.tween_property(character,"modulate:a",target,duration)
