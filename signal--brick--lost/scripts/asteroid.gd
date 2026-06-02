extends Node2D

var speed = 100

func _process(delta):
	position.y += speed * delta
	
	if position.y >800:
		position.y = -50
