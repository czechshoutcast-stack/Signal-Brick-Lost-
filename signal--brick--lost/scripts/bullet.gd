extends Area2D
 #kulka 
var speed = 400
#vystřel
func _process(delta):
	position.y -= speed * delta

	if position.y < -20:
		queue_free()
#zasah
func _on_area_entered(area):
	if area.has_method("hit"):
		area.hit()
		queue_free()
