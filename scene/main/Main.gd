extends Node

signal game_start

var score

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$HUD.show_game_over()
	$GameMusic.stop()
	$Player.is_alive = false

func new_game():
	score = 0
	get_tree().call_group("mobs", "queue_free")
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$ScoreTimer.start()
	emit_signal("game_start")
	$GameMusic.play()
	$Player.is_alive = true

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _physics_process(delta):
	#allow escape to quit game
	if Input.is_action_just_pressed("exit_game"):
		get_tree().quit()
