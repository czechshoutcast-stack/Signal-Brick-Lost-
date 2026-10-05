extends CharacterBody2D
#pohyb hrače a zasahy jsem linej to popisovat dál :D (tohle je player)
var speed = 200.0
var hp = 3
var max_hp = 5
var invincible = false
var bullet_scene = preload("res://sceny/bullet.tscn")
var shoot_cooldown = 0.2
var shoot_timer = 0.0
var bombs = 3

@onready var shoot_sound = $ShootSound
@onready var explosion_sound = $ExplosionSound

func _ready():
	call_deferred("init_bomb_ui")
	
func init_bomb_ui():
	if get_tree().current_scene.has_method("update_bombs"):
		get_tree().current_scene.update_bombs(bombs)

func hitstop(time := 0.05):
	Engine.time_scale = 0.1
	await get_tree().create_timer(time, true, false, true).timeout
	Engine.time_scale = 1.0

#lečení
func heal(ammount):
	hp = min(hp + ammount, max_hp)
	get_tree().current_scene.update_hp(hp)

#zasach
func hit():
	if invincible:
		return
	
	invincible = true
	
	#TODO: hit sound
	#hit_sound.play()
	
	var cam = get_viewport().get_camera_2d()
	if cam:
		cam.add_shake(8.0)
	
	hp -= 1
	#print("HP:", hp)
	get_tree().current_scene.update_hp(hp)
	
	#fedback (bliknutí)
	modulate =Color.RED
	
	await hitstop(0.05)
	
	await get_tree().create_timer(0.1).timeout
	modulate = Color.WHITE
	
	if hp <=0:
		die()
		return
	
	#cooldown
	await get_tree().create_timer(0.8).timeout
	invincible = false
	
func die():
	Engine.time_scale = 1.0
	get_tree().current_scene.game_over()
	queue_free()

@warning_ignore("unused_parameter")
func _physics_process(delta):
	var direction = Vector2.ZERO
	
	#pohyb
	if !get_tree().current_scene.game_started:
		return
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
	
	#střelba
	shoot_timer -= delta
	
	if Input.is_action_pressed("ui_accept") and shoot_timer <= 0:
		shoot()
		shoot_timer = shoot_cooldown
	
	#bomba
	if Input.is_action_just_pressed("bomb"):
		use_bomb()

func use_bomb():
	if bombs <= 0:
		return
	
	bombs -= 1
	get_tree().current_scene.update_bombs(bombs)
	
	explosion_sound.play()
	
	for asteroid in get_tree().get_nodes_in_group("asteroids"):
		asteroid.hit(false, false)

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position + Vector2(0, -10)
	get_parent().add_child(bullet)
	
	shoot_sound.play()

func _on_hitbox_area_entered(area):
	if area.has_method("hit"):
		hit()
