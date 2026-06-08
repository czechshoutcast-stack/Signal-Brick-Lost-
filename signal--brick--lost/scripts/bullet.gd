extends Area2D
  
var speed = 400

func _process(delta):
	position.y -= speed * delta

	if position.y < -20:
		queue_free()

func _on_area_entered(area):
	if area.has_method("hit"):
		area.hit()
		queue_free()
