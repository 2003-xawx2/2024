extends Area2D

@export var spring_impulse:=1000
@export var force_direction:Node2D

signal bounce


func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		var direction:= force_direction.global_position - global_position
		direction = direction.normalized()
		(body as RigidBody2D).apply_impulse(direction*spring_impulse)
		bounce.emit()
