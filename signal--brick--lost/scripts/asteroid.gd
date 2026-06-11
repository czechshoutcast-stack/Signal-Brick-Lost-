extends Area2D

@export var speed = 100
@export var size = 1 # 1 = velký, 2 = medium, 3 = malý

var direction = Vector2.ZERO

func _ready():
	if direction == Vector2.ZERO:
		direction = Vector2(randf_range(-0.5, 0.5), 1).normalized()
	
	$Sprite2D.scale = Vector2.ONE * (2.0 / size)

func _process(delta):
	position += direction * speed * delta
	
	if position.y >800:
		queue_free()

func hit():
	get_tree().current_scene.add_score(10)
	
	if size < 3:
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

func _on_area_entered(area):
	if area.has_method("hit"):
		area.hit()
	print("COLLIDE WITH:", area.name)
