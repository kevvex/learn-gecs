# Follow the example_inventory in GECS repository to learn
[csprance - example_inventory](https://github.com/csprance/gecs/tree/main/example_inventory)

## Set up the ECS basic world environment
1. Create a scene and call it ```main.tscn```
2. Click ```Node2D``` and name it ```Main```
3. Attach a script called ```main.gd``` then put the following in it:

```gdscript
extends Node2D

@onready var world: World = $World

func _ready() -> void:
	ECS.world = world

func _physics_process(delta: float) -> void:
	world.process(delta, "physics")
```

4. Click on ```Main``` -> ```Add Child Node``` -> ```World``` (from the GECS library) -> Name it ```World```

5. Click on ```World``` -> ```Node``` -> Name it ```Entities```
6. Click on ```World``` -> ```Node``` -> Name it ```Systems```
7. Click on ```World``` -> ```Inspector``` -> ```Entity Nodes Root``` -> ```Assign``` -> ```Entities```
8. Click on ```World``` -> ```Inspector``` -> ```System Nodes Root``` -> ```Assign``` -> ```Systems```

## Create the hero scene
1. Create a new directory ```entities``` and add a new scene called ```hero.tscn``` or copy the ```hero.tscn``` scene 
2. Open the ```hero.tscn``` scene
3. Add a new ```Node2D``` and call it ```Hero```
4. Create a new directory called ```components```
5. In the scene tree click on ```Hero``` -> ```Attach a script``` -> ```components/c_hero.gd```
6. Add the following to it:
```gdscript
## Identity tag for the player character. Systems that read input or resolve
## "the player" query on this instead of hardcoding a node path.
class_name C_Hero
extends Component
```
7. Click on ```Systems``` -> ```Add Child Node``` -> ```SystemGroup``` -> Rename to ```physics```
8. Click on ```physics``` -> ```HeroMovementSystem```
