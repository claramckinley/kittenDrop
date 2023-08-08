extends Node2D

onready var player = $YSort/Player
onready var inventory = $UserInterface/Inventory

func _process(delta):
	if inventory.visible == true:
		player.whichScene = player.Scene.PAUSED
	else:
		player.whichScene = player.Scene.MAIN
