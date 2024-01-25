extends Node
class_name state_machine

@export var animation_player:AnimationPlayer
@export var character:CharacterBody2D
@export var debug:bool = false


var state_dictionary:Dictionary = {}
var previos_state:basic_state
var current_state:basic_state:
	set(value):
		previos_state = current_state
		current_state = value
	get:
		return current_state
#var hit_stop_frames:=0: #打击暂停几帧
	#set(value):
		#hit_stop_frames = value
		#hit_stop_frames_process_minus = value
		#character.process_mode = Node.PROCESS_MODE_DISABLED
		#set_process(true)
	#get:
		#return hit_stop_frames
#var hit_stop_frames_process_minus:=0


func _ready() -> void:
	#set up name-state dictionary
	for child in get_children():
		if ! child is basic_state:
			continue
		state_dictionary[child.state_name] = child
		(child as basic_state).set_up_state(character,animation_player)

	set_process(false)


func get_state(state_name:String)->basic_state:
	if state_dictionary.has(state_name):
		return state_dictionary[state_name]
	else:
		return null


func change_state(state_name:String)->void:
	var new_state:=get_state(state_name)
	if current_state == new_state:
		return
	current_state = new_state
	current_state.process_mode = Node.PROCESS_MODE_ALWAYS
	current_state.initialize()


#hit stop logic -------------------------------------------------------
#func _process(delta: float) -> void:
	#if hit_stop_frames_process_minus >0:
		#hit_stop_frames_process_minus-=1
	#else:
		#character.process_mode = Node.PROCESS_MODE_ALWAYS
		#set_process(false)
#hit stop interface
#func set_hit_stop_frames(frames:int)->void:
	#hit_stop_frames = frames
