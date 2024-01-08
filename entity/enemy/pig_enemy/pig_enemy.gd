extends CharacterBody2D


@onready var state_factory: state_machine = $state_machine
@onready var graphic: Node2D = $Graphic
@onready var animation_player: AnimationPlayer = $Graphic/AnimationPlayer
@onready var hit: Node = $state_machine/hit


func _ready() -> void:
	state_factory.change_state("idle")


func _process(delta: float) -> void:
	flip_on_velocity()


func flip_on_velocity()->void:
	if animation_player.current_animation == "hit" and animation_player.is_playing():
		return
	var velocity_x = velocity.x
	if velocity_x > 0:
		graphic.scale.x = -1
	else:
		graphic.scale.x = 1


#region state interface & signal
#attack state use function
func get_attack_vector()->Vector2:
	return Vector2(-1,0) if graphic.scale.x == 1 else Vector2(1,0)


func _on_hit_box_be_hit(direction: Vector2) -> void:
	state_factory.change_state("hit")
	hit.hit_direction = direction


func _on_health_manager_die() -> void:
	hit.died = true
#endregion
