extends Area2D

@export var speed = 100
@export var size = 1 # 1 = velký, 2 = medium, 3 = malý

var direction = Vector2.ZERO
var explosion_scene = preload("res://sceny/explosion.tscn")

#začátek
func _ready():
	add_to_group("asteroids")
	
	if direction == Vector2.ZERO:
		direction = Vector2(randf_range(-0.5, 0.5), 1).normalized()
	if size == 1:
		$Sprite2D.scale = Vector2(2, 2)
	elif size == 2:
		$Sprite2D.scale = Vector2(1.5, 1.5)
	else:
		$Sprite2D.scale = Vector2(1, 1)

#let
func _process(delta):
	if !get_tree().current_scene.game_started:
		return
	
	position += direction * speed * delta
	
	if position.y >800:
		queue_free()

#zasah
func hit(split := true, play_sound := true):
	get_tree().current_scene.add_score(10)
	
	#5% šance na hp
	if randf() < 0.05:
		var hp_pickup = preload("res://sceny/healt-pickup.tscn").instantiate()
		hp_pickup.global_position = global_position
		get_tree().current_scene.call_deferred("add_child", hp_pickup)
	
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	explosion.play_sound = play_sound
	get_tree().current_scene.call_deferred("add_child", explosion)
	#debug
	#print("ASTEROID:", global_position)
	#print("EXPLOSION:", explosion.global_position)
	
	if split and size < 3:
		for i in 2:
			var new_ast = load("res://sceny/asteroid.tscn").instantiate()
			new_ast.global_position = global_position + Vector2(
				randf_range(-50, 50),
				randf_range(-50, 50)
				)
			
			new_ast.size = size +1
			new_ast.speed = speed * 1.3
			new_ast.direction = Vector2(
				randf_range(-1.0, 1.0),
				randf_range(-1.0, 1.0)
			).normalized()
			
			get_parent().call_deferred("add_child", new_ast)
		
	call_deferred("queue_free")

#zasach meteoru
func _on_area_entered(area):
	if area.has_method("hit"):
		area.hit()
	#print("COLLIDE WITH:", area.name)
