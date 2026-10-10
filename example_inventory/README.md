## Beginner's GECS example: move a Hero with a System

This example shows how to set up a GECS `World`, make an entity from a scene, give it components, and let a system move it. The finished scene and scripts are already in this folder; you can run them or follow along and recreate each part.

For the upstream example, see [GECS example_inventory](https://github.com/csprance/gecs/tree/main/example_inventory).

### What you will build

A `Hero` entity is a `CharacterBody2D`. It has a `C_Hero` tag component and a `C_MoveSpeed` data component. `HeroMovementSystem` finds entities with both components and moves them when you press WASD.

The scene tree should look like this:

```text
Main
└── World
    ├── Entities
    │   └── Hero
    └── Systems
        └── physics (SystemGroup)
            └── HeroMovementSystem
```

### Before you start

1. Open this Godot project (`learn-gecs`) in the editor. The GECS plugin and the `ECS` autoload are included in the project.
2. To use the GECS Explorer, open **Project > Project Settings > GECS** and enable **Debug Mode**. The project already has this enabled; this step matters if you are recreating the setup in a different project.
3. The movement input actions (`move_left`, `move_right`, `move_forward`, and `move_backwards`) are already configured in this project under **Project > Project Settings > Input Map**.

### 1. Create the Main scene and World

1. Create a new scene with a `Node2D` root named `Main`, and save it as `example_inventory/main.tscn`.
2. Attach a script named `main.gd` to `Main`:

   ```gdscript
   extends Node2D

   @onready var world: World = $World

   func _ready() -> void:
       ECS.world = world

   func _process(delta: float) -> void:
       world.process(delta, "input")
       # Add world.process(delta, "gameplay") here if you add gameplay systems.

   func _physics_process(delta: float) -> void:
       world.process(delta, "physics")
   ```

   `ECS.world = world` tells the GECS autoload which world is active. The calls to `world.process` run systems in the named groups. This example's movement system runs in `physics`; the `input` and `gameplay` groups are available if you add systems that use them.

3. Add a GECS `World` node as a child of `Main`.
4. Add two plain `Node` children to `World`, named `Entities` and `Systems`.
5. Select `World`. In the Inspector, set **Entity Nodes Root** to `Entities` and **System Nodes Root** to `Systems`. These paths tell the world where to find its entities and systems.

### 2. Make the Hero entity and its components

1. Create a scene with a `CharacterBody2D` root named `Hero`, and save it as `example_inventory/entities/e_hero.tscn`.
2. Attach `example_inventory/entities/e_hero.gd` to the root:

   ```gdscript
   class_name Hero
   extends Entity

   func define_components() -> Array:
	   return [
		   C_Hero.new(),
		   C_MoveSpeed.new(220.0)
	   ]
   ```

   Extending `Entity` makes the scene a GECS entity. `define_components()` gives every Hero the two components this example uses.

3. Create `example_inventory/components/c_hero.gd`:

   ```gdscript
   class_name C_Hero
   extends Component
   ```

   This is a tag component: its presence identifies an entity as a Hero.

4. Create `example_inventory/components/c_move_speed.gd`:

   ```gdscript
   class_name C_MoveSpeed
   extends Component

   @export var speed: float = 220.0

   func _init(_speed: float = 220.0) -> void:
	   speed = _speed
   ```

   This component stores the Hero's movement speed in pixels per second.

5. Add a `CollisionShape2D` and any visuals you want under `Hero`. The example scene uses a circle collision shape and a small `ColorRect` and `Label`; these are for the Godot scene, not required by GECS.

### 3. Create the movement system

1. Create `example_inventory/systems/s_hero_movement_system.gd`:

   ```gdscript
   class_name HeroMovementSystem
   extends System

   func query() -> QueryBuilder:
       return q.with_all([C_Hero, C_MoveSpeed])

   func process(entities: Array[Entity], _components: Array, _delta: float) -> void:
       var direction := Input.get_vector(
           "move_left", "move_right", "move_forward", "move_backwards"
       )

       for entity in entities:
           var body := entity as Node as CharacterBody2D
           var c_speed := entity.get_component(C_MoveSpeed) as C_MoveSpeed
           body.velocity = direction * c_speed.speed
           body.move_and_slide()
   ```

   The query means this system only processes entities that have **both** components. For each matching entity, it reads the speed component and moves its `CharacterBody2D`.

2. In the scene tree, add a GECS `SystemGroup` under `Systems` and name it `physics`.
3. Add a `HeroMovementSystem` node under the `physics` group and attach the script. The group name assigns the system to the `physics` group.

### 4. Assemble and run the scene

1. Instance `e_hero.tscn` under `World/Entities`.
2. Confirm the `World` node has **Entity Nodes Root** set to `Entities` and **System Nodes Root** set to `Systems`.
3. Save all files. Open `main.tscn` and run the current scene with **F6**. (F5 runs the project's configured main scene, which may be a different scene.)
4. Use **W**, **A**, **S**, and **D** to move the Hero.
5. With Debug Mode enabled, the GECS Explorer should connect to the running game and show the active world, Hero entity, its components, and the movement system.

### If the Hero or system does not appear in the Explorer

- Run the scene from the Godot editor with **F6**; running the game outside the editor does not attach the editor debugger.
- Make sure **GECS > Debug Mode** is enabled in Project Settings.
- Check that `ECS.world = world` runs and that the Hero is beneath the configured `Entities` node.
- Check that the system is beneath the configured `Systems` node and inside the `physics` SystemGroup.
- Check the Output panel for script errors. A script error during startup can stop the world from being set up.
