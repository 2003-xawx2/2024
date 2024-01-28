extends CharacterBody2D
class_name lick_dog

@onready var animation_player: AnimationPlayer = $Graphic/AnimationPlayer
@onready var state_factory = $StateMachine
@onready var graphic: Node2D = $Graphic
@onready var ridicule: Node2D = $Ridicule
@onready var walk = $StateMachine/walk
@onready var jump = $StateMachine/jump
@export var random_talk: Array[String]

@export var npc: CharacterBody2D
@export var force: float
@export var force_y: float

static var instance:lick_dog
var died:=false
var carry = 0
var dirty = 0
var encounter = 0
var if_first_encounter:=false

func _ready() -> void:
	instance = self
	Global.player_born_position = global_position
	#state_factory.change_state("show")
	state_factory.change_state("idle")


func enter_encounter()->void:
	if !if_first_encounter:
		if_first_encounter = true
		state_factory.current_state.change_state("encounter")


func _process(delta: float) -> void:
	flip_on_velocity(delta)


func flip_on_velocity(delta: float)->void:
	#if npc.global_position.x < global_position.x:
		#walk.acceleration = 10 - force * (global_position.x - npc.global_position.x)
		#jump.acceleration = 10 - force * (global_position.x - npc.global_position.x)
		#var acceleration_y = force_y * (global_position.x - npc.global_position.x)
		#velocity.y -= delta * acceleration_y
	#else:
		#walk.acceleration = 10
		#jump.acceleration = 10
	#if npc != null:
		#if npc.global_position.x < global_position.x:
			#var acceleration = 10 - force * (global_position.x - npc.global_position.x)
			#velocity.x += acceleration * delta
	if animation_player.current_animation == "hit" and animation_player.is_playing():
		return
	var velocity_x = velocity.x
	if velocity_x > 2:
		graphic.scale.x = 1
	elif velocity_x < -2:
		graphic.scale.x = -1


#region handle input

func get_input_movement()->Vector2:
	return Input.get_vector("left","right","down","up")


func is_jump_input()->bool:
	if Input.is_action_pressed("ui_accept"):
		return true
	return false

#endregion

#region handle signal


func get_face_direction()->Vector2:
	return Vector2(1,0) if graphic.scale.x == 1 else Vector2(-1,0)

#endregion

#region interact

func if_can_swing()->bool:
	if state_factory.current_state.state_name == "jump" || "fall":
		return true
	return false


func carry_standing_board(board: Node2D)->void:
	carry = 1


func is_carry_board():
	return carry


func get_dirty():
	dirty = 1
	print(dirty)
	pass


#endregion



