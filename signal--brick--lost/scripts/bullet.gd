extends ColorRect

var speed = 400

func _process(delta):
	position.y -= speed * delta

	if position.y < -20:
		queue_free()
