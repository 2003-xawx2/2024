extends basic_state

@onready var timer = $Timer


func initialize()->void:
	super()
	animation_player.play("encounter")
	timer.start()


func quit()->void:
	super()


func _physics_process(delta):
	stand(delta)


func _on_timer_timeout():
	change_state("idle")
