# main.gd
extends Node

@onready var world: World = $World

func _ready():
	ECS.world = world
	ECS.world.add_system(VelocitySystem.new())
	ECS.world.add_system(InputSystem.new())
	
	var player = preload("res://entities/e_player.tscn").instantiate()
	ECS.world.add_entity(player)

func _process(delta):
	ECS.process(delta)
	
