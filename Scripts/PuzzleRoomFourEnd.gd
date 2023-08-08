extends Node2D

onready var player = $Player
onready var textbox = $Player/Textbox
onready var acceptButton = $Player/Textbox/TextboxContainer/MarginContainer/HBoxContainer/AcceptButton

func _ready():
	acceptButton.connect("accepted", self, "was_accepted")
	player.whichScene = player.Scene.PAUSED
	textbox.queue_text("did you let someone follow you here, Spooky?", false)
	textbox.queue_text("*crickets*", false)
	textbox.queue_text("hey you...you want a piece of me?", false)
	textbox.queue_text("i challenge you to rock paper scissors", true)

func was_accepted():
	get_tree().change_scene("res://Scenes/PlatformerMiniGame.tscn")



func _on_AcceptButton_pressed():
	get_tree().change_scene("res://Pawspector Valley/Scenes/Rooms/Platformer.tscn")
