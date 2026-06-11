extends Node2D

var score = 0
var high_score = 0
var is_game_over = false

@onready var score_label = $ui/ScoreLabel
@onready var game_over_label = $ui/GameOverLabel
@onready var high_score_label = $ui/HighScoreLabel
@onready var restart_button = $ui/RestartButton
@onready var hp_label = $ui/HPLabel

func update_hp(value):
	hp_label.text = "HP: " + str(value)

func add_score(points):
	score += points
	score_label.text = "Score: " + str(score)

func game_over():
	if is_game_over:
		return
		
	is_game_over = true
	$ui/GameOverLabel.visible = true
	$ui/RestartButton.visible = true
	$ui/HighScoreLabel.visible = true
	print("GAME OVER")
	if score > high_score:
		high_score = score
		print("NEW HIGH SCORE:", high_score)
	high_score_label.text = "High Score: " + str(high_score)

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
