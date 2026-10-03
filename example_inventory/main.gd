extends Node2D

@onready var world: World = $World

func _ready() -> void:
	ECS.world = world

func _process(delta: float) -> void:
	world.process(delta, "input")
	#world.process(delta, "gameplay")

func _physics_process(delta: float) -> void:
	world.process(delta, "physics")
