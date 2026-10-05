extends Control

@onready var high_score_screen_label = $HighScoreScreenLabel

func _on_texture_button_pressed() -> void:
	visible = false
	get_parent().get_node("MainMenu").visible = true

func update_high_score_screen():
	var score = get_parent().high_score
	high_score_screen_label.text = "\n" + str(score)
