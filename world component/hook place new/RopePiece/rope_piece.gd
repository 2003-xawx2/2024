extends RigidBody2D

const ROPE_PIECE = preload("res://world component/hook place new/RopePiece/rope_piece.tscn")
@onready var pin_joint_2d: PinJoint2D = $PinJoint2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var shape := (collision.shape as RectangleShape2D)
@onready var line_2d: Line2D = $Line2D


func initialize(nums_to_spawn:int,length:float,player_connect:RigidBody2D)->void:
	if nums_to_spawn == 1:
		player_connect.reparent(self)
		pin_joint_2d.position = Vector2.DOWN * length
		pin_joint_2d.node_b = "PlayerConnect"
		return
	var new_rope = ROPE_PIECE.instantiate()
	new_rope.position = Vector2.DOWN * length

	pin_joint_2d.position = Vector2.DOWN * length
	pin_joint_2d.node_b = "RopePiece"
	add_child(new_rope)
	new_rope.initialize(nums_to_spawn - 1,length,player_connect)


func _process(delta: float) -> void:
	shape.size.y = pin_joint_2d.position.y
	line_2d.points[1] = pin_joint_2d.position