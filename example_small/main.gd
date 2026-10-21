# main.gd
extends Node

@onready var world: World = $World

func _ready():
	ECS.world = world
	
	ECS.world.add_system(UserInputSystem.new())
	ECS.world.add_system(MovementSystem.new())
	ECS.world.add_system(HealthSystem.new())

func _process(delta):
	ECS.process(delta)
	
