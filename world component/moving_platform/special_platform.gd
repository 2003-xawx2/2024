@tool
extends StaticBody2D

enum State{
	NoCollisionWithVisiual,
	NoVisiualWithCollison,
	Normal
}

@onready var visible_collision_manager: Area2D = $VisibleCollisionManager


@export var object_state:State:
	set(value):
		if !is_node_ready():
			await ready
		visible_collision_manager.object_state = value
		object_state = value
	get:
		return object_state

@export var texture:Texture:
	set(value):
		$Sprite2D.texture = value
		texture = value
	get:
		return texture
#@export var initial_direction:Vector2 = Vector2(1,0)
#@export var time_to_change:float = 2
#@export var velocity:float = 30

func _ready() -> void:
	visible_collision_manager.object_state = object_state
	$Sprite2D.texture = texture
