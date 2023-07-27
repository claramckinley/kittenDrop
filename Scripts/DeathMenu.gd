extends Control

onready var restartButton = $VBoxContainer/RestartFightButton

var playerStats = PlayerStats

func _ready():
	restartButton.grab_focus()

func _on_QuitButton_pressed():
	get_tree().quit()


func _on_RestartFightButton_pressed():
	var bossFight = load("res://Scenes/RatSwarm/RatSwarm.tscn").instance()
	playerStats.health = playerStats.max_health
	get_tree().change_scene(bossFight)
	get_tree().reload_current_scene()
	

func _on_GoToMenuButton_pressed():
	playerStats.health = playerStats.max_health
	get_tree().change_scene("res://Scenes/Menu.tscn")
