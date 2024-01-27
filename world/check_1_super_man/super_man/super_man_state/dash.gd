extends basic_state

@onready var dash_timer: Timer = $DashTimer
@onready var dash_particle: GPUParticles2D = $"../../Graphic/PlayerSprite/DashParticle"

@export var dash_time :float = .5

var dash_direction:Vector2
var target_velocity:Vector2


func _ready() -> void:
	super()
	dash_particle.emitting = false


func initialize()->void:
	super()
	dash_particle.emitting = true
	character.ridicule.talk("超人所向披靡！",.1)
	animation_player.play("dash")
	dash_timer.start(dash_time)
	dash_direction = character.mouse_direction
	dash_particle.rotation = dash_direction.angle()
	target_velocity = dash_direction * max_speed


func quit()->void:
	super()
	dash_particle.emitting = false


func _physics_process(delta: float) -> void:
	character.velocity = character.velocity.lerp \
	(target_velocity ,1-exp(-delta*acceleration))
	character.move_and_slide()



func _on_dash_timer_timeout() -> void:
	if character.is_on_floor():
		change_state("walk")
	else:
		change_state("fall")
