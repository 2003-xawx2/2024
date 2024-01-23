extends Node
class_name TimeManager

signal time(minute:int,second:int)

var minute_timer:Timer
var minutes := 0
var seconds:=0:
	set(value):
		if seconds == 60:
			seconds = 0
			minutes += 1
		else:
			seconds = value
		time.emit(minutes,seconds)
	get:
		return seconds

func _ready() -> void:
	var second_timer = Timer.new()
	add_child(second_timer)
	second_timer.wait_time = 1
	second_timer.start()
	second_timer.timeout.connect(_on_second_timer_timeout)


func _on_second_timer_timeout()->void:
	seconds+=1
