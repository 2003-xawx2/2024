extends basic_die
@onready var player_collision: CollisionPolygon2D = $"../../PlayerCollision"


func initialize()->void:
	#player_collision.disabled = true
	super()


func quit()->void:
	super()
	#player_collision.disabled = false
