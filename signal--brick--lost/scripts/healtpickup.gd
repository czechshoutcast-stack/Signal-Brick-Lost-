extends Area2D
#picup na HP
@export var speed = 100

#zaklad
func _process(delta):
	position.y += speed * delta
	
	if position.y > 800:
		queue_free()

#náraz do hráče
func _on_body_entered(body):
	if body.has_method("heal"):
		body.heal(1)
		queue_free()


func _on_area_entered(area):
	var player = area.get_parent()
	if player.has_method("heal"):
		player.heal(1)
		queue_free()
