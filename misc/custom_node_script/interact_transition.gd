extends InteractArea
class_name InteractChangeScene

@export_file("*.tscn") var scene_change_to:String


func _interact()->void:
	super()
	Transition.change_scene_to(scene_change_to)

