extends basic_state
class_name basic_walk


var move_direction:Vector2 = Vector2.ZERO


func initialize()->void:
	super()
	animation_player.play("walk")


func quit()->void:
	super()


func _physics_process(delta: float) -> void:
	move(delta,move_direction)



#handle input
