extends Node


class Flags:
	signal changed

	var flag_saving := preload("res://misc/savings/flags_savings.tres")
	var _flags := []

	func has(flag:String)->bool:
		return flag in _flags

	func add(flag:String)->void:
		if !has(flag):
			_flags.append(flag)
			changed.emit()
			save()

	func save()->void:
		flag_saving.save(_flags)

	func _load()->void:
		_flags = flag_saving.flags

	func reset()->void:
		_flags.clear()
		save()

var flags := Flags.new()

var current_camera:Camera2D


func hit_stop(time:float = .1,time_scale:float = .5):
	Engine.time_scale = time_scale
	var tween:=create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_method(func(_time_scale:float):Engine.time_scale = _time_scale
		,Engine.time_scale,1,time*1.5)
