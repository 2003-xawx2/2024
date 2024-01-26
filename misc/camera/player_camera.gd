extends Camera2D
class_name player_camera

@onready var check_out_timer: Timer = $CheckOutTimer
@onready var signal_timer: Timer = $SignalTimer

@export var map:Node2D
@export var zoom_in_check_time = 10
@export var check_out_offset:Vector2

signal check_out_ready

var _duration = 0.0
var _period_in_ms = 0.0
var _amplitude = 0.0
var _timer = 0.0
var _last_shook_timer = 0
var _previous_x = 0.0
var _previous_y = 0.0
var _last_offset = Vector2(0, 0)

var check_out_tween:Tween
var target_global_position:Vector2
var reset_zoom:Vector2
var if_checking:bool = false


func _ready() -> void:
	reset_zoom = zoom
	Global.current_camera = self

	var used :Rect2i =map.get_used_rect().grow(-1)
	var _scale := map.scale.x
	var tile_size :Vector2i= map.tile_set.tile_size

	limit_bottom=int(used.end.y*tile_size.y*_scale)
	limit_top=int(used.position.y*tile_size.y*_scale)
	limit_left=int(used.position.x*tile_size.x*_scale)
	limit_right=int(used.end.x*tile_size.x*_scale)
	reset_smoothing()
	force_update_scroll()

	set_process(true)


func check_out_player(time:float = 1)->void:
	check_out(player_character.instance,time)


func check_out(object:Node2D,time:float = 1)->void:
	if_checking = true
	target_global_position = object.position + check_out_offset

	signal_timer.start(zoom_in_check_time - .1)
	check_out_timer.start(zoom_in_check_time + time)

	if check_out_tween and check_out_tween.is_running():
		check_out_tween.kill()

	check_out_tween =create_tween()
	check_out_tween.parallel().tween_property(self,"global_position",target_global_position,zoom_in_check_time)
	check_out_tween.parallel().tween_property(self,"zoom",10 * Vector2.ONE,zoom_in_check_time).\
	set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC)

	check_out_tween.tween_interval(time)
	check_out_tween.tween_property(self,"zoom",reset_zoom,.6)


func _process(delta: float) -> void:
	if if_checking:
		check_out_process(delta)
	shake_process(delta)


func check_out_process(delta:float)->void:
	global_position = global_position.lerp(target_global_position,1-exp(-delta * 5))


# Shake with decreasing intensity while there's time remaining.
func shake_process(delta:float):
	# Only shake when there's shake time remaining.
	if _timer == 0:
		return
	# Only shake on certain frames.
	_last_shook_timer = _last_shook_timer + delta
	# Be mathematically correct in the face of lag; usually only happens once.
	while _last_shook_timer >= _period_in_ms:
		_last_shook_timer = _last_shook_timer - _period_in_ms
		# Lerp between [amplitude] and 0.0 intensity based on remaining shake time.
		var intensity = _amplitude * (1 - ((_duration - _timer) / _duration))
		# Noise calculation logic from http://jonny.morrill.me/blog/view/14
		var new_x = randf_range(-1.0, 1.0)
		var x_component = intensity * (_previous_x + (delta * (new_x - _previous_x)))
		var new_y = randf_range(-1.0, 1.0)
		var y_component = intensity * (_previous_y + (delta * (new_y - _previous_y)))
		_previous_x = new_x
		_previous_y = new_y
		# Track how much we've moved the offset, as opposed to other effects.
		var new_offset = Vector2(x_component, y_component)
		set_offset(get_offset() - _last_offset + new_offset)
		_last_offset = new_offset
	# Reset the offset when we're done shaking.
	_timer = _timer - delta
	if _timer <= 0:
		_timer = 0
		set_offset(get_offset() - _last_offset)


# Kick off a new screenshake effect.
func shake(duration:float= .2, frequency:= 20, amplitude:= 20):
	if frequency == 0: return
	# Initialize variables.
	_duration = duration
	_timer = duration
	_period_in_ms = 1.0 / frequency
	_amplitude = amplitude
	_previous_x = randf_range(-1.0, 1.0)
	_previous_y = randf_range(-1.0, 1.0)
	# Reset previous offset, if any.
	set_offset(get_offset() - _last_offset)
	_last_offset = Vector2(0, 0)


func _on_check_out_timer_timeout() -> void:
	position = Vector2.ZERO
	if_checking = false


func _on_signal_timer_timeout() -> void:
	check_out_ready.emit()
