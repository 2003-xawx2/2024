extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var top_label: Label = $Top/TopLabel
@onready var middle_label: Label = $Middle/MiddleLabel
@onready var down_label: Label = $Down/DownLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var slow_down_scale:= .1


var labels : Array[Label]
var tween:Tween


func _ready() -> void:
	labels = [top_label,middle_label,down_label]
	labels.all(func(label:Label):
		label.modulate.a = 0)



func show_word_one(a:String,speed_scale:=1)->void:
	change_modulate(1)
	change_engine_time_scale(slow_down_scale)

	top_label.text = a
	animation_player.speed_scale  *= speed_scale
	animation_player.play("One")
	await animation_player.animation_finished

	change_modulate(0)
	change_engine_time_scale(1)


func show_word_two(a:String,b:String,speed_scale:=1)->void:
	change_modulate(1)
	change_engine_time_scale(slow_down_scale)

	top_label.text = a
	middle_label.text = b
	animation_player.speed_scale *= speed_scale
	animation_player.play("Two")
	await animation_player.animation_finished

	change_modulate(0)
	change_engine_time_scale(1)


func show_word_three(a:String,b:String,c:String,speed_scale:float=1)->void:
	change_modulate(1)
	change_engine_time_scale(slow_down_scale)

	top_label.text = a
	middle_label.text = b
	down_label.text = c
	animation_player.speed_scale *= speed_scale
	animation_player.play("Three")
	await animation_player.animation_finished

	change_modulate(0)
	change_engine_time_scale(1)


func change_engine_time_scale(scale:float)->void:
	Engine.time_scale = scale
	animation_player.speed_scale = 1.0/scale


func change_modulate(target:float = 0)->void:
	if tween and tween.is_running():
		tween.kill()

	tween = create_tween().set_ease(Tween.EASE_IN_OUT)\
	.set_trans(Tween.TRANS_CIRC).set_parallel(true)
	for child in get_children():
		if child is AnimationPlayer:
			continue

		tween.tween_property(child,"modulate:a",target,.3)
		#tween.tween_interval(.05)

	tween.chain()


#animationplayer call
func shake()->void:
	Global.current_camera.shake(.05,500,10)
