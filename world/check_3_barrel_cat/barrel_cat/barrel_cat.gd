extends RigidBody2D

@onready var animation_player: AnimationPlayer = $Graphic/AnimationPlayer
@onready var gpu_particles_2d: GPUParticles2D = $Graphic/Sprite2D/GPUParticles2D
@onready var view_hider: Sprite2D = $ViewHider
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


@export var _ridicule: ridicule
@export var force:=400
@export var random_audios:Array[String]


var start_roll:=false
var previous_position:Vector2
var showing:=true:
	set(value):
		freeze = value
	get:
		return freeze
var rolling:=false:
	set(value):
		if rolling == value:
			return

		rolling = value
		if value == true:
			gpu_particles_2d.emitting = true
			roll_sound()
		else:
			gpu_particles_2d.emitting = false
			stop_roll_sound()
	get:
		return rolling


func _ready() -> void:
	showing = true
	talk()
	Global.current_camera.check_out(self,1.8)
	Global.current_camera.check_out_ready.connect(func():
		animation_player.play("show"),CONNECT_ONE_SHOT)
	animation_player.animation_finished.connect(func(current_animation:String):
		showing = false
		animation_player.play("roll"))

	BigWorldMode.show_word_three("你 是","酒桶里的","猫",.5)
	#animation_player.play("roll")


func _process(delta: float) -> void:
	if showing:return

	var input_direction := Vector2(Input.get_axis("left","right"),0)
	if input_direction != Vector2.ZERO:
		apply_force(input_direction * force)
		rolling = true
	else:
		rolling = false

	#if previous_position.distance_squared_to(global_position) < 10:
		#animation_player.play_backwards("transition")
		#animation_player.queue("show")
		#start_roll = false
	#else:
		#if !start_roll:
			#animation_player.play("transition")
			#animation_player.queue("RESET")
			#start_roll = true
	#previous_position = global_position


func roll_sound()->void:
	if audio_stream_player.playing:
		return

	audio_stream_player.play()
	talk()


func stop_roll_sound()->void:
	audio_stream_player.volume_db = -20
	talk()


func _on_hide_view_area_area_entered(area: Area2D) -> void:
	var tween:=create_tween()
	tween.tween_property(view_hider,"modulate:a",0,10)


func talk()->void:
	_ridicule.talk(random_audios.pick_random(),.5)
