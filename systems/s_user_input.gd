class_name UserInputSystem
extends System

func query() -> QueryBuilder:
	return q.with_all([C_UserInput, C_Velocity])

func process(entities: Array[Entity], components: Array, delta: float) -> void:
	
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	for entity: Entity in entities:
		var input = entity.get_component(C_UserInput) as C_UserInput
		var vel = entity.get_component(C_Velocity) as C_Velocity
		vel.direction = input_dir * input.speed

		if Input.is_action_just_pressed("kill"):
			var health = entity.get_component(C_Health) as C_Health
			if health:
				health.current = -2
				health.is_dead = true
				
