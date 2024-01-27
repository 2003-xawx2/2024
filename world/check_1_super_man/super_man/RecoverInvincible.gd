extends Node2D


@onready var recover_timer: Timer = $RecoverTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: superman = $"../.."
@onready var hit_collision: CollisionShape2D = $"../HitBox/CollisionShape2D"
@onready var player_collision: CollisionPolygon2D = $"../../PlayerCollision"

@onready var collisions:Array = [hit_collision,player_collision]


func recover()->void:
	collisions.all(func(collision):
		collision.disabled = true)
	animation_player.play("recover")
	recover_timer.start()


func _on_recover_timer_timeout() -> void:
	animation_player.stop()
	player.modulate.a = 1
	collisions.all(func(collision):
		collision.disabled = false)
