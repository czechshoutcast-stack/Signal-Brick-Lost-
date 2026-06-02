extends CharacterBody2D

var speed = 200.0

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
	
	velocity = direction.normalized() * 200.0
	move_and_slide()

	if Input.is_action_just_pressed("ui_accept"):
		shoot()

func shoot():
	var bullet = ColorRect.new()
	bullet.color = Color.WHITE
	bullet.size = Vector2(4, 4)
	bullet.global_position = global_position + Vector2(0, -10)
	bullet.set_script(load("res://scripts/bullet.gd"))
	get_parent().add_child(bullet)
