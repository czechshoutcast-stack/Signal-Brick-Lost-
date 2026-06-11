extends CharacterBody2D

var speed = 200.0
var hp = 3

var bullet_scene = preload("res://sceny/bullet.tscn")

func hit():
	hp -= 1
	print("HP:", hp)
	get_tree().current_scene.update_hp(hp)
	if hp <=0:
		die()
	
func die():
	get_tree().current_scene.game_over()
	queue_free()

@warning_ignore("unused_parameter")
func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x +=1
	if Input.is_action_pressed("ui_left"):
		direction.x -=1 
	if Input.is_action_pressed("ui_down"):
		direction.y +=1
	if Input.is_action_pressed("ui_up"):
		direction.y -=1
	
	if get_tree().current_scene.is_game_over:
		return
	
	velocity = direction.normalized() * 200.0
	move_and_slide()

	if Input.is_action_just_pressed("ui_accept"):
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position + Vector2(0, -10)
	get_parent().add_child(bullet)

func _on_hitbox_area_entered(area):
	if area.has_method("hit"):
		hit()
