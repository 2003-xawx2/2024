extends basic_state
class_name air_state


func initialize()->void:
	super()


func quit()->void:
	super()


var vel_x:float
func air_move(delta:float,gravity:= default_gravity)->void:
	var new_direction = (character as player_character).get_input_movement()
	character.velocity.y += gravity * delta
	if new_direction!=Vector2.ZERO:
		vel_x = character.velocity.x
		vel_x = lerp(vel_x,new_direction.x*max_speed,1-exp(-acceleration*delta))
		character.velocity.x = vel_x
	character.move_and_slide()
