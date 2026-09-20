# e_player.gd — attach to a Node2D root in e_player.tscn
class_name Player
extends Entity

func define_components() -> Array:
	return [C_Health.new(), C_Velocity.new(), C_UserInput.new()]

func on_ready():
	var c_vel = get_component(C_Velocity) as C_Velocity
	if c_vel:
		c_vel.direction = Vector2.RIGHT
