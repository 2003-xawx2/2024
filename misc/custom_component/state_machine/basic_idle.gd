extends basic_state
class_name basic_idle


func initialize()->void:
	super()
	animation_player.play("idle")


func quit()->void:
	super()


func _physics_process(delta: float) -> void:
	stand(delta)




#handle input
