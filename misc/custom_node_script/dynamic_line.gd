@tool
extends Line2D
class_name DynamicLine2D

@export var pointA:Node2D:
	set(value):
		pointA = value
		if points.size() < 2:
			points.append(pointA.position)
		else:
			points[0] = pointA.position
			set_process(true)
	get:
		return pointA
@export var pointB:Node2D:
	set(value):
		pointB = value
		if points.size() < 2:
			points.append(pointB.position)
		else:
			points[1] = pointB.position
			set_process(true)
	get:
		return pointB


func _ready() -> void:
	points.append(pointA.position)
	points.append(pointB.position)


func _process(delta: float) -> void:
	points[0] = Vector2.ZERO
	points[1] = pointB.position
