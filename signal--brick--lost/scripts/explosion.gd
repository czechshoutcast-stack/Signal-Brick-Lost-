extends Node2D
#KABOOM Bayby

var play_sound := true

@onready var particles = $GPUParticles2D
@onready var anim = $AnimatedSprite2D
@onready var  explosion_sound = $ExplosionSound

func _ready():
	particles.emitting = true
	if play_sound:
		explosion_sound.play()
	#debug
	#print("EXPLOSION FINAL POSITION:", global_position)
	anim.play("explosion")

func _on_animated_sprite_2d_finished():
		queue_free()
