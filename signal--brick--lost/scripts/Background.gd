extends Node2D
#vesmírné pozadí
@export var scroll_speed = 50.0
@export var bg_height = 1024.0

@onready var bg1 = $BG1
@onready var bg2 = $BG2

#začátek
func _ready():
	bg1.position = Vector2(576, 512)
	bg2.position = Vector2(-576, -512)

#fyzika
func _physics_process(delta):
	if !get_tree().current_scene.game_started:
		return
	
	bg1.position.y += scroll_speed * delta
	bg2.position.y += scroll_speed * delta
	
	if bg1.position.y >= 512 + bg_height:
		bg1.position.y = bg2.position.y - bg_height
	
	if bg2.position.y >= 512 + bg_height:
		bg2.position.y = bg1.position.y - bg_height
