extends Area2D
class_name HitBox

signal be_hit(direction:Vector2)

@export var health_component:HealthManager


func _ready():
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if not area is HurtBox:
		print_debug("Area is not hurt_box!")
		return

	if health_component==null:
		print_debug("HealthManager is null!")
		return

	var hurt_box_component = area as HurtBox
	hurt_box_component.hurt.emit()
	health_component.damage(hurt_box_component.damage)
	be_hit.emit((global_position - hurt_box_component.global_position).normalized())

