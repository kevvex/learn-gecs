class_name C_Velocity 
extends Component

@export var direction: Vector2 = Vector2.ZERO

func _init(v: Vector2 = Vector2.ZERO) -> void:
	direction = v
