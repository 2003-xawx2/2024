extends Node
class_name basic_state

@export var state_name:String = "walk"
@export var acceleration:float = 10
@export var max_speed:float = 200

var is_work:=false
var animation_player:AnimationPlayer
var state_factory:state_machine
var character:CharacterBody2D
var state_time:float = 0
static var default_gravity:float = ProjectSettings.get("physics/2d/default_gravity")


func _ready() -> void:
	state_factory = get_parent()
	process_mode = Node.PROCESS_MODE_DISABLED


func set_up_state(_character:CharacterBody2D,_animation_player:AnimationPlayer)->void:
	character = _character
	animation_player = _animation_player
	state_time = 0


func initialize()->void:
	is_work = true
	state_time = 0
	set_process(true)
	set_physics_process(true)


func quit()->void:
	is_work = false
	set_process(false)
	set_physics_process(false)


func stand(delta:float,gravity:float = default_gravity)->void:
	var velocity :Vector2 = character.get_real_velocity()
	
	velocity.y += gravity * delta/4
	velocity.x = lerp(velocity.x,float(0),1-exp(-delta*acceleration))
	
	character.velocity = velocity
	character.move_and_slide()


func move(delta:float,direction:Vector2,gravity:float = default_gravity)->void:

	var velocity :Vector2 = character.get_real_velocity()
	
	velocity.y += gravity * delta/4
	velocity.x = lerp(velocity.x,direction.x*max_speed,1-exp(-delta*acceleration))
	
	character.velocity = velocity
	character.move_and_slide()


func _process(delta: float) -> void:
	state_time += delta


func change_state(state:String):
	quit()
	print(name+"->"+state)
	state_factory.change_state(state)
	process_mode = Node.PROCESS_MODE_DISABLED




