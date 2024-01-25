extends Node
class_name SelfTween


static func change_modulate(node:Node,target:float=0,duration:float = .3,tween:Tween = null)->Tween:
	if tween and tween.is_running():
		tween.kill()

	tween = node.create_tween()
	tween.tween_property(node,"modulate:a",target,duration)
	return tween
