extends Control

func _on_texture_button_pressed() -> void:
	visible = false
	get_parent().get_node("MainMenu").visible = true
