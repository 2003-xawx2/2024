extends Sprite2D


const EGG_YOLK_BULLET = preload("res://world/check_1_super_man/super_man/egg yolk bullet/egg_yolk_bullet.tscn")

@onready var super_man: superman = $"../.."
@onready var attack_timer: Timer = $AttackTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var bullet_emit_position:Marker2D
@export var attack_interval:= .3


func _on_super_man_attack(flag: bool) -> void:
	if flag == true:
		spawn_bullet()
		attack_timer.start(attack_interval)
	else:
		attack_timer.stop()
		animation_player.stop()


func spawn_bullet()->void:
	$RandomAudioPlayer.play_random()
	animation_player.play("attack")
	var egg := EGG_YOLK_BULLET.instantiate()
	super_man.get_parent().add_child(egg)
	egg.global_position = bullet_emit_position.global_position
	egg.emit(super_man.mouse_direction)


func _on_attack_timer_timeout() -> void:
	spawn_bullet()
