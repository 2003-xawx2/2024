extends Node2D

@onready var barrel_cat: RigidBody2D = $barrel_cat
@onready var _ridicule: ridicule = $Ridicule


func _ready() -> void:
	show()


func _process(delta: float) -> void:
	_ridicule.global_position = barrel_cat.global_position + Vector2.UP*55


