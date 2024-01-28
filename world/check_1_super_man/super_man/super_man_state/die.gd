extends basic_die
@onready var player_collision: CollisionPolygon2D = $"../../PlayerCollision"

@export var random_talk:Array[String]

func initialize()->void:
	super()
	$RandomAudioPlayer.play_random()
	character.ridicule.talk(random_talk.pick_random(),1)
	BigWorldMode.show_word_two("你","死了")


func quit()->void:
	super()
	#player_collision.disabled = false
