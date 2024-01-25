extends basic_die
@onready var player_collision: CollisionPolygon2D = $"../../PlayerCollision"


func initialize()->void:
	(character as player_character).ridicule.talk("完蛋",1)
	BigWorldMode.show_word_two("你","死了")
	super()


func quit()->void:
	super()
	#player_collision.disabled = false
