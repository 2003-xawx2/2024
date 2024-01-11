extends basic_hit

@onready var detect_player_ray: ShapeCast2D = $"../../Graphic/Ray/DetectPlayerRay"


func _ready() -> void:
	super()


func initialize()->void:
	super()
	animation_player.queue("attack")


func quit()->void:
	super()


func _physics_process(delta: float) -> void:
	if hit_frames > 0:
		hit_frames -= 1
		hit(delta)
		return
	
	character.velocity.y+=default_gravity*delta
	character.move_and_slide()


func _process(delta: float) -> void:
	super(delta)
	
	#state change
	if animation_player.current_animation == "hit":
		return
	
	if died: 
		change_state("die")
		return
	if character.is_on_floor():
		change_state("attack")

