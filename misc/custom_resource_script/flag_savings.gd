extends Resource
class_name flag_savings

@export var flags:Array


func save(_flags:Array)->void:
	flags = _flags
	ResourceSaver.save(self)
