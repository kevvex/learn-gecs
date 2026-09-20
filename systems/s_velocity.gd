class_name VelocitySystem
extends System

func query() -> QueryBuilder:
	return q.with_all([C_Velocity])

func process(entities: Array[Entity], components: Array, delta: float) -> void:
	for entity: Entity in entities:
		var vel = entity.get_component(C_Velocity) as C_Velocity
		entity.position += vel.direction * delta
