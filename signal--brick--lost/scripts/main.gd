extends Node2D
#přidat label při překonaní high score a uklidit if v game over

var game_started = false
var score = 0
var high_score = 0
var is_game_over = false
var new_high_score = false
var difficulty_level = 0
var bonus_bricks = 0
var asteroid_speed_multiplier = 1.0

@onready var score_label = $ui/ScoreLabel
@onready var game_over_label = $ui/GameOverLabel
@onready var high_score_label = $ui/HighScoreLabel
@onready var restart_button = $ui/RestartButton
@onready var hp_label = $ui/HPLabel
@onready var best_score_label = $ui/BestScoreLabel
@onready var music_player = $MusicPlayer
@onready var bomb_label = get_node_or_null("ui/BombLabel")
@onready var main_menu = $MainMenu
@onready var high_score_screen = $Hiscore
@onready var credits_screen = $CreditsScreen
@onready var menu_music = $MenuMusic

#high score save
func save_high_score():
	var file = FileAccess.open("user://save.dat", FileAccess.WRITE)
	file.store_32(high_score)

#high score load
func load_high_score():
	if FileAccess.file_exists("user://save.dat"):
		var file = FileAccess.open("user://save.dat", FileAccess.READ)
		high_score = file.get_32()

func _ready():
	menu_music.play()
	load_high_score()
	score_label.text = "Score: 0"
	best_score_label.text = "Hi-score: " + str(high_score)
	high_score_label.text = "High Score: " + str(high_score)
	
	main_menu.visible = true
	high_score_screen.visible = false
	credits_screen.visible = false
	$StartScreen.visible = false
	#print("BombLabel path test:", get_node_or_null("ui/BombLabel"))

#start hry
func start_game():
	game_started = true
	new_high_score = false
	score = 0
	is_game_over = false
	$Player.visible = true
	$ui/UIstat.visible = true
	$ui/ScoreLabel.visible = true
	$ui/BestScoreLabel.visible = true
	$ui/HPLabel.visible = true
	$ui/BombLabel.visible = true
	$StartScreen.visible = false
	menu_music.stop()
	music_player.play()
	
#func _process(delta):
	#if !game_started and Input.is_action_just_pressed("ui_accept"):
	#	start_game()

#bomby
func update_bombs(value):
	var label = get_node_or_null("ui/BombLabel")
	bomb_label.text = "Bombs: " + str(value)

#hp
func update_hp(value):
	hp_label.text = "HP: " + str(value)

#skoré
func add_score(points):
	score += points
	score_label.text = "Score: " + str(score)
	
	var new_level = int(score / 1000)
	
	if new_level > difficulty_level:
		difficulty_level = new_level
		asteroid_speed_multiplier += 0.15
		bonus_bricks +=1
		print("difficulty up:", difficulty_level, " speed:", asteroid_speed_multiplier)
	
	if score > high_score:
		high_score = score
		save_high_score()
		new_high_score = true
	
	best_score_label.text = "Hi-score: " + str(high_score)

func game_over():
	if is_game_over:
		return
		
	is_game_over = true
	$ui/GameOverLabel.visible = true
	$ui/RestartButton.visible = true
	$ui/HighScoreLabel.visible = true
	print("GAME OVER")
	high_score_label.text = "High Score: " + str(high_score)
	
	if new_high_score:
		high_score_label.text = "NEW HIGH SCORE: " + str(high_score)

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
