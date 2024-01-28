extends Node2D


@onready var detect_area = $"DetectArea"

var player = null

func enter()->bool:
	var bodies := detect_area.get_overlapping_bodies() as Array
	if !bodies.is_empty():
		player = bodies.front()
	else:
		return false
	if player == null:
		return false
	return true
	

func _physics_process(delta):
	if enter():
		player.get_dirty()
