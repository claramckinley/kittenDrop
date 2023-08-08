extends Control


onready var startButton = $VBoxContainer/StartButton

func _ready():
	startButton.grab_focus()

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/ShantyTown.tscn")
	



func _on_OptionsButton_pressed():
	var options = load("res://Scenes/Options.tscn").instance()
	get_tree().current_scene.add_child(options)


func _on_QuitButton_pressed():
	get_tree().quit()
