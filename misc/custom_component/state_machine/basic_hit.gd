extends basic_state
class_name basic_hit

@export_category("hit")
@export var all_hit_frames:int = 10
@export var hit_acceleration:float= 500
@export var hit_velocity:float= 400
@export var hit_collision:CollisionShape2D


var hit_velocity_x:float
var hit_frames:int
var hit_direction:Vector2 = Vector2.ZERO
var died = false


func initialize()->void:
	super()
	hit_frames = all_hit_frames
	animation_player.play("hit")
	hit_collision.set_deferred("disabled",true)


func quit()->void:
	super()
	hit_direction = Vector2.ZERO
	hit_collision.set_deferred("disabled",false)
	#set_deferred("died",false)


func _physics_process(delta: float) -> void:
	if hit_frames > 0:
		hit_frames -= 1
		hit(delta)
		return

	character.velocity.y += default_gravity * delta/4
	hit_velocity_x /= 1.01
	character.velocity.x = hit_velocity_x
	character.move_and_slide()


func hit(delta:float)->void:
	var velocity :Vector2 = character.velocity
	var hit_target_velocity = hit_direction*hit_velocity+Vector2.UP*hit_velocity/2
	if hit_target_velocity.y > hit_velocity:
		hit_target_velocity.y = hit_velocity
	velocity = velocity.lerp(hit_target_velocity,1-exp(-delta*hit_acceleration))
	hit_velocity_x = velocity.x

	character.velocity = velocity
	character.move_and_slide()
