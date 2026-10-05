extends Node2D

@export var asteroid_scene: PackedScene
@export var spawn_rate = 1

func _ready():
	randomize()
	_spawn_loop()

func _spawn_loop(): 
	while true:
		if get_tree().current_scene.game_started:
			var spawn_count = 1 + get_tree().current_scene.bonus_bricks
			
			for i in range(spawn_count):
				spawn_asteroid()
		
		await get_tree().create_timer(spawn_rate).timeout

func spawn_asteroid():
	var a = asteroid_scene.instantiate()
	
	a.position = Vector2(
		randf_range(0, 1024),
		-50
	)
	a.speed *= get_tree().current_scene.asteroid_speed_multiplier
	
	get_parent().add_child.call_deferred(a)
