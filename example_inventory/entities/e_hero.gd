class_name Hero
extends Entity

func define_components() -> Array:
	return [
		C_Hero.new(),
		C_MoveSpeed.new(220.0)
	]
