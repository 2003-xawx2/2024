extends Node

class_name HealthManager

signal die
signal health_changed #定义信号，每次血量变化需要检测是否死亡，并且更新血条
var flag:bool = false

@export var max_health:float=10
var current_health:float


func _ready() -> void:
	current_health = max_health

#当玩家或者敌人需要血条的时候需要血量的占比
func get_health_percent()->float:
	if current_health > max_health or current_health <=0:
		return 0
	return float(current_health)/max_health

#供主体调用的函数，来控制血量
func damage(damage_amount:float)->void:
	current_health = max(0,current_health - damage_amount)
	health_changed.emit()
	if current_health == 0 and flag == false:
		die.emit()
		flag= true
