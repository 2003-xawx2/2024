extends RigidBody2D

@onready var contact_ground_particle: GPUParticles2D = $ContactGroundParticle
@onready var emit_particle: GPUParticles2D = $EmitParticle
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

@export var initial_impulse:= 400


func emit(direction:Vector2)->void:
	apply_impulse(direction * initial_impulse)
	animation_player.play("emit")
	emit_particle.rotation = direction.angle()


func _on_detect_area_body_entered(body: Node2D) -> void:
	animation_player.play("hit")
	await animation_player.animation_finished
	queue_free()

