extends Node2D


@onready var yunnan_mushroom: Area2D = $SpecialTile/YunnanMushroom
@onready var barrel_cat: RigidBody2D = $Entity/CatContainer/barrel_cat



func _on_player_detecter_body_entered(body: Node2D) -> void:
	await get_tree().create_timer(7).timeout
	var tween:=create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	tween.tween_property(yunnan_mushroom,"global_position",barrel_cat.global_position,1)
