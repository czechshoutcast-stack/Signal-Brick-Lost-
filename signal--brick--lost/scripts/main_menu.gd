extends Control

#high_sore_screen
func _on_hig_score_buton_pressed() -> void:
	visible = false
	get_parent().get_node("Hiscore").visible = true
	get_parent().get_node("Hiscore").update_high_score_screen()

#new game
func _on_new_game_button_pressed() -> void:
	visible = false
	get_parent().start_game()

#credits srceen
func _on_credits_button_pressed() -> void:
	get_parent().get_node("CreditsScreen").visible = true
