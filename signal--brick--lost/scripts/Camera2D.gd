extends Camera2D
#važně? ten extend jasně říkí co toje
var shake_strength := 0.0

func add_shake(amount: float):
	shake_strength = max(shake_strength, amount)

func _process(delta):
	if shake_strength > 0:
		offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
		shake_strength = lerp(shake_strength, 0.0, 5 * delta)
	else:
		offset = Vector2.ZERO
