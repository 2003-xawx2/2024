extends CharacterBody2D


@onready var detect_area = $"DetectArea"
@onready var ridicule = $Ridicule

@export var pickup_y: float
@export var random_talk: Array[String]
@export var standing_board: Node2D
@export var standing_board_distance: float


@onready var detect_player_ray = $Graphic/Ray/DetectCPlayerRay
@onready var state_factory: state_machine = $state_machine
@onready var graphic: Node2D = $Graphic
@onready var animation_player: AnimationPlayer = $Graphic/AnimationPlayer


var player = null
var nearby = 0


func _ready() -> void:
	state_factory.change_state("idle")


func _process(delta: float) -> void:
	flip_on_velocity()
	if detect_player_ray.is_colliding():
		lick_dog.instance.enter_encounter()


func flip_on_velocity()->void:
	var velocity_x = velocity.x
	if velocity_x > 0:
		graphic.scale.x = -1
	else:
		graphic.scale.x = 1


func enter()->bool:
	var bodies := detect_area.get_overlapping_bodies() as Array
	if !bodies.is_empty():
		player = bodies.front()
	else:
		return false
	if player == null:
		return false

	return true


func say():
	(self as CharacterBody2D).ridicule.talk(random_talk.pick_random())


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("world2_interact"):
		if nearby:
			say()


func near_standing_board():
	if self.global_position.distance_to(standing_board.global_position) < standing_board_distance:
		return true
	return false


func _physics_process(delta):
	if enter():
		nearby = 1
	else:
		nearby = 0
